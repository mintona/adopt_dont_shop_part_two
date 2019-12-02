# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(name: "Boulder Shelter",
                          address: "123 Arapahoe Ave",
                          city: "Boulder",
                          state: "CO",
                          zip: "80301")

shelter_2 = Shelter.create(name: "Denver Shelter",
                          address: "345 Blake St",
                          city: "Denver",
                          state: "CO",
                          zip: "80220")

shelter_3 = Shelter.create(name: "Beverly Hills Shelter",
                          address: "414 Rodeo Dr",
                          city: "Beverly Hills",
                          state: "CA",
                          zip: "90210")

shelter_4 = Shelter.create(name: "New York Shelter",
                          address: "1001 Central Park Ave",
                          city: "New York",
                          state: "NY",
                          zip: "02134")


pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

pet_1 = Pet.create!(image: pet_1_image,
                    name: "Alex",
                    approximate_age: "10",
                    sex: "Male",
                    shelter: shelter_1,
                    description: pet_1_description)

pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
pet_2 = Pet.create!(image: pet_2_image,
                    name: "Marley",
                    approximate_age: "8 weeks",
                    sex: "Female",
                    shelter: shelter_1,
                    description: pet_2_description)

pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
pet_3_description = "I'm a jelly fish! Watch out, I sting!"
pet_3 = Pet.create!(image: pet_3_image,
                    name: "Peanut",
                    approximate_age: "2",
                    sex: "Female",
                    shelter: shelter_2,
                    description: pet_3_description)

pet_4_image = "https://images.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"
pet_4_description = "I'm the most beautiful bird there ever was!"
pet_4 = Pet.create!(image: pet_4_image,
                    name: "PeaPea",
                    approximate_age: "6",
                    sex: "Male",
                    shelter: shelter_3,
                    description: pet_4_description)
