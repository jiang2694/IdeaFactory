# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Review.delete_all
Idea.delete_all
User.delete_all


NUM_IDEAS = 100
PASSWORD = "111"


super_user = User.create(
  name: "1",
  email: "1@1.com",
  password: PASSWORD
)


5.times do
  name = Faker::Name.first_name
  User.create(
    name: name,
    email: "#{name}#{Faker::Name.last_name}@1.com",
    password: PASSWORD
  )
end

users = User.all

NUM_IDEAS.times do
  created_at = Faker::Date.backward(days: 365 * 5)
  i=Idea.create(
  title: Faker::Hacker.say_something_smart,
  description:  Faker::ChuckNorris.fact,
  created_at: created_at,
  updated_at: created_at,
  user: users.sample
 )
 if i.valid?
   i.reviews = rand(0..20).times.map do
     Review.new(
      body: Faker::Hacker.say_something_smart,
      user: users.sample
     )
   end
 end
end

idea = Idea.all
review = Review.all

puts Cowsay.say("Generated #{idea.count} ideas", :koala)
puts Cowsay.say("Generated #{users.count} users", :koala)

