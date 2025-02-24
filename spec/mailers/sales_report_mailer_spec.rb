require "rails_helper"

RSpec.describe SalesReportMailer, type: :mailer do
  describe "send_report" do
    let(:csv_content) { "Test CSV Content" }
    let(:start_date) { Date.today.beginning_of_month }
    let(:end_date) { Date.today.end_of_month }
    let(:file_path) { Rails.root.join("tmp", "test_sales_report.csv") }

    before do
      File.write(file_path, csv_content)
    end

    after do
      File.delete(file_path) if File.exist?(file_path)
    end

    let(:mail) { described_class.send_report(file_path, start_date, end_date) }

    it "renders the subject" do
      expect(mail.subject).to eq("Sales Report from #{start_date} to #{end_date}")
    end

    it "sends to the correct recipient" do
      expect(mail.to).to eq(["admin@clientfirstlabs.io"])
    end

    it "attaches the correct CSV file" do
      expect(mail.attachments.first.filename).to eq("sales_report_#{start_date}_to_#{end_date}.csv")
    end
  end
end
