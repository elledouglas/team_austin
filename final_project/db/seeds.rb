# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(
user_name: "Billy Bob Joe",
full_name: "Bill Joe",
email: "billybobjoe@gmail.com",
age: 30,
gender: "male",
children: 2,
sexual_preference: "female",
password: "susieq"
)

User.new(
user_name: "Andrew_K",
full_name: "Andrew Klein",
email: "andrewk@gmail.com",
age: 20,
gender: "male",
children: 0,
sexual_preference: "female",
password: "klein"
)
