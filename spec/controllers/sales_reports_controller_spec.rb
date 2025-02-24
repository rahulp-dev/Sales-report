require 'rails_helper'

RSpec.describe SalesReportsController, type: :controller do
  describe "POST #create" do
    let(:start_date) { "2024-02-01" }
    let(:end_date) { "2024-02-28" }
    let(:customer_name) { "John Smith" }

    it "enqueues GenerateSalesReportJob" do
      expect {
        post :create, params: { start_date: start_date, end_date: end_date, customer_name: customer_name }
      }.to have_enqueued_job(GenerateSalesReportJob).with(start_date, end_date, customer_name)
    end

    it "sets a flash notice" do
      post :create, params: { start_date: start_date, end_date: end_date, customer_name: customer_name }
      expect(flash[:notice]).to eq("Sales report is being generated. You will receive an email shortly.")
    end

    it "redirects to the root path" do
      post :create, params: { start_date: start_date, end_date: end_date, customer_name: customer_name }
      expect(response).to redirect_to(root_path)
    end
  end
end