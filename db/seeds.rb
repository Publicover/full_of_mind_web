# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
365.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'Airship123'
  user.save!
  puts "User #{user.email} created..."
  75.times do
    feeling = Feeling.new
    feeling.body = Faker::Games::Witcher.quote
    feeling.user_id = user.id
    puts "\t...and is feeling #{feeling.body}"
    feeling.save!
  end
  user.feelings.last(4).each { |feel| feel.current! }
end
