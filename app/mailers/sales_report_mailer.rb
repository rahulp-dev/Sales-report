class SalesReportMailer < ApplicationMailer
  default to: "admin@clientfirstlabs.io"

  def send_report(file_path, start_date, end_date)
    @start_date = start_date
    @end_date = end_date

    attachments["sales_report_#{start_date}_to_#{end_date}.csv"] = File.read(file_path, mode: "rb")

    mail(to: "admin@clientfirstlabs.io", subject: "Sales Report from #{start_date} to #{end_date}")
  end
end
