require 'rails_helper'

RSpec.describe SalesReportService, type: :service do
  let(:start_date) { Date.today.beginning_of_month }
  let(:end_date) { Date.today.end_of_month }
  let(:customer_name) { "John David" }
  let!(:customer_sales) { Sale.create!([{ amount: 100, created_at: start_date + 1.day, customer_name: customer_name },
                                      { amount: 200, created_at: start_date + 1.day, customer_name: customer_name },
                                      { amount: 300, created_at: start_date + 1.day, customer_name: customer_name }]) }

  let!(:other_sales) { Sale.create!([{ amount: 150, created_at: start_date + 2.days, customer_name: "Jane Smith" },
                                   { amount: 250, created_at: start_date + 2.days, customer_name: "Jane Smith" }]) }
  let(:mail_double) { double("SalesReportMailer", deliver_now: true) }

  before do
    allow(SalesReportMailer).to receive(:send_report).and_return(mail_double)
    allow(File).to receive(:delete)
  end

  describe "#call" do
    context "when customer name is provided" do
      it "fetches sales only for that customer" do
        service = SalesReportService.new(start_date, end_date, customer_name)
        expect(service.send(:fetch_sales)).to match_array(customer_sales)
      end
    end

    context "when customer name is not provided" do
      it "fetches sales for all customers" do
        service = SalesReportService.new(start_date, end_date)
        expect(service.send(:fetch_sales)).to match_array(customer_sales + other_sales)
      end
    end

    it "generates a CSV file" do
      service = SalesReportService.new(start_date, end_date, customer_name)
      sales_relation = Sale.where(id: customer_sales.map(&:id))
      csv_path = service.send(:generate_csv, sales_relation)
      expect(File).to exist(csv_path)
      File.delete(csv_path)
    end

    it "sends the report via email" do
      service = SalesReportService.new(start_date, end_date, customer_name)
      expect(SalesReportMailer).to receive(:send_report).and_return(mail_double)
      service.call
    end

    it "deletes the CSV file after sending email" do
      service = SalesReportService.new(start_date, end_date, customer_name)
      allow(File).to receive(:delete)
      service.call
      expect(File).to have_received(:delete).with(kind_of(String))
    end

    context "when email sending fails" do
      before do
        allow(SalesReportMailer).to receive(:send_report).and_raise(StandardError, "Email failed")
      end

      it "logs the error and raises exception" do
        service = SalesReportService.new(start_date, end_date, customer_name)
        expect(Rails.logger).to receive(:error).with(/Email failed/)
        expect { service.call }.to raise_error(StandardError, "Email failed")
      end
    end
  end
end
