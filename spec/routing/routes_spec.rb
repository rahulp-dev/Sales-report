require 'rails_helper'

RSpec.describe "Routing", type: :routing do
  it "root to sales_reports#new" do
    expect(get: "/").to route_to("sales_reports#new")
  end

  it "GET sales_reports#new" do
    expect(get: "/sales_reports/new").to route_to("sales_reports#new")
  end

  it "POST sales_reports#create" do
    expect(post: "/sales_reports").to route_to("sales_reports#create")
  end

  it "/up to rails health check" do
    expect(get: "/up").to route_to("rails/health#show")
  end
end
