require 'rails_helper'

RSpec.describe GenerateSalesReportJob, type: :job do
  include ActiveJob::TestHelper

  let(:start_date) { Date.today.beginning_of_month.to_s }
  let(:end_date) { Date.today.end_of_month.to_s }
  let(:customer_name) { "John Doe" }

  after { clear_enqueued_jobs }

  it "queues the job in the default queue" do
    expect {
      described_class.perform_later(start_date, end_date, customer_name)
    }.to have_enqueued_job(described_class).on_queue("default")
  end

  it "calls SalesReportService with correct arguments" do
    service = instance_double(SalesReportService)
    allow(SalesReportService).to receive(:new).with(start_date, end_date, customer_name).and_return(service)
    allow(service).to receive(:call)

    perform_enqueued_jobs do
      described_class.perform_later(start_date, end_date, customer_name)
    end

    expect(SalesReportService).to have_received(:new).with(start_date, end_date, customer_name)
    expect(service).to have_received(:call)
  end
end
