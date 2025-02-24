class SalesReportService
  RETRY_LIMIT = 3
  CHUNK_SIZE = 500

  attr_reader :start_date, :end_date, :customer_name

  def initialize(start_date, end_date, customer_name = nil)
    @start_date = start_date
    @end_date = end_date
    @customer_name = customer_name
  end

  def call
    sales = fetch_sales
    file_path = generate_csv(sales).to_s

    begin
      SalesReportMailer.send_report(file_path, start_date, end_date).deliver_now
    rescue StandardError => e
      Rails.logger.error("Email failed: #{e.message}")
      raise e
    ensure
      File.delete(file_path) if File.exist?(file_path)
    end
  end

  private

  def fetch_sales
    sales = Sale.by_date_range(start_date, end_date)
    sales = sales.by_customer(customer_name) if customer_name.present?
    sales
  end

  def generate_csv(sales)
    timestamp = Time.current.to_i
    file_path = Rails.root.join("tmp", "sales_report_#{start_date}_to_#{end_date}_#{timestamp}.csv")

    begin
      CSV.open(file_path, "wb") do |csv|
        csv << ["Sales Report from #{start_date} to #{end_date}"]
        csv << []
        csv << ["Total Sales Amount: #{sales.sum(:amount)}"]
        csv << []
        csv << ["ID", "Amount", "Created At", "Customer Name"]

        sales.find_in_batches(batch_size: CHUNK_SIZE) do |batch|
          batch.each do |sale|
            csv << [sale.id, sale.amount, sale.created_at, sale.customer_name]
          end
        end
      end
    rescue StandardError => e
      Rails.logger.error("CSV Generation failed: #{e.message}")
      raise e
    end

    file_path
  end
end
