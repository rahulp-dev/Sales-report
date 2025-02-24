class Sale < ApplicationRecord
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :by_customer, ->(customer_name) { where(customer_name: customer_name) }
end
