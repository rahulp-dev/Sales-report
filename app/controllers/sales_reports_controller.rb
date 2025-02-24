class SalesReportsController < ApplicationController
  def create
    start_date, end_date = params[:start_date], params[:end_date]
    customer_name = params[:customer_name]

    GenerateSalesReportJob.perform_later(start_date, end_date, customer_name)

    flash[:notice] = "Sales report is being generated. You will receive an email shortly."
    redirect_to root_path
  end
end
