class GenerateSalesReportJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  def perform(start_date, end_date, customer_name = nil)
    SalesReportService.new(start_date, end_date, customer_name).call
  end
end
