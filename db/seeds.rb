Like.delete_all

Review.delete_all

Product.delete_all

User.delete_all

NUM_OF_PRODUCTS = 20
PASSWORD = "supersecret"

users = User.all

super_user = User.create(
  first_name: "Derek",
  last_name: "Leung",
  email: "derek@leung.com",
  password: PASSWORD,
  admin: true
)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  u = User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end


NUM_OF_PRODUCTS.times do
  p = Product.create(
    title: Faker::Pokemon.name,
    description: Faker::Pokemon.move,
    price: rand(1000),
    user: users.sample
  )

  
  # if p.valid?
    rand(1..8).times do
      r = Review.create(
        rating: rand(1..5),
        body: Faker::GreekPhilosophers.quote,
        user: users.sample
        )
        
        r.likers = users.shuffle.slice(0, rand(users.count))

        p.reviews << r
    end
  # end
end

# puts Cowsay.say "Generated #{Product.count} products", :cow

reviews = Review.all

puts Cowsay.say("Generated #{Product.count} products", :cow)
puts Cowsay.say("Generated #{reviews.count} reviews", :frogs)
puts Cowsay.say("Generated #{User.count} users", :frogs)
puts Cowsay.say("Generated #{Like.count} Likes", :frogs)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
