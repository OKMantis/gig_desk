Refund.destroy_all
Booking.destroy_all
Concert.destroy_all
Customer.destroy_all

Concert.create!([
  { title: "Neon Skyline Tour",  venue: "Riverside Arena", starts_at: 3.weeks.from_now,  price: 55.00, tickets_available: 120 },
  { title: "Acoustic Sessions",  venue: "The Velvet Room", starts_at: 10.days.from_now,  price: 30.00, tickets_available: 40 },
  { title: "Midnight Synthwave", venue: "Warehouse 9",     starts_at: 2.months.from_now, price: 42.50, tickets_available: 200 },
  { title: "Last Night's Show",  venue: "Riverside Arena", starts_at: 1.week.ago,        price: 60.00, tickets_available: 0 }
])

Customer.create!([
  { name: "Maya Torres", email: "maya@example.com",  credit_balance: 500.00 },
  { name: "Jonas Berg",  email: "jonas@example.com", credit_balance: 75.00 },
  { name: "Priya Nair",  email: "priya@example.com", credit_balance: 20.00 }
])

puts "Seeded #{Concert.count} concerts and #{Customer.count} customers."