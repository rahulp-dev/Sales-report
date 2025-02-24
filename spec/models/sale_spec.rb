require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe "Scopes" do
    let!(:sale1) { create(:sale, created_at: "2024-02-10", customer_name: "John Doe") }
    let!(:sale2) { create(:sale, created_at: "2024-02-15", customer_name: "Jane David") }
    let!(:sale3) { create(:sale, created_at: "2024-03-01", customer_name: "John Doe") }

    it "filters by date range" do
      expect(Sale.by_date_range("2024-02-01", "2024-02-28")).to contain_exactly(sale1, sale2)
    end

    it "filters by customer name" do
      expect(Sale.by_customer("John Doe")).to contain_exactly(sale1, sale3)
    end
  end
end
