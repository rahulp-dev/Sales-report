require 'faker'

puts "Seeding Sales Data..."

1000.times do
  Sale.create!(
    amount: Faker::Commerce.price(range: 50.0..1000.0),
    customer_name: Faker::Name.name,
    created_at: Faker::Time.between(from: 2.months.ago, to: Time.now)
  )
end

puts "1000 sales records created successfully."
