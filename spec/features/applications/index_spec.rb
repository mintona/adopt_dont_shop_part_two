# require 'rails_helper'
#
# RSpec.describe "As a visitor" do
#   # describe "after one or more applications have been created" do
#   #   before(:each) do
#   #     @shelter_1 = Shelter.create(name: "Boulder Shelter",
#   #                               address: "123 Arapahoe Ave",
#   #                               city: "Boulder",
#   #                               state: "CO",
#   #                               zip: "80301")
#   #
#   #     pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
#   #     pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"
#   #
#   #     @pet_1 = Pet.create(image: pet_1_image,
#   #                         name: "Alex",
#   #                         approximate_age: "10",
#   #                         sex: "Male",
#   #                         description: pet_1_description,
#   #                         shelter: @shelter_1)
#   #
#   #     @shelter_2 = Shelter.create(name: "Denver Shelter",
#   #                               address: "345 Blake St",
#   #                               city: "Denver",
#   #                               state: "CO",
#   #                               zip: "80220")
#   #
#   #     pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
#   #     pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
#   #     @pet_2 = Pet.create(image: pet_2_image,
#   #                         name: "Marley",
#   #                         approximate_age: "2",
#   #                         sex: "Female",
#   #                         description: pet_2_description,
#   #                         shelter: @shelter_2)
#   #
#   #     pets = [@pet_1, @pet_2]
#   #
#   #     pets.each do |pet|
#   #       visit "/pets/#{pet.id}"
#   #       click_button 'Add to Favorite Pets'
#   #     end
#   #
#   #     application = Application.create!(name: 'Jordan Holtkamp',
#   #                                       address: '123 Main St',
#   #                                       city: 'Lafayette',
#   #                                       state: 'CO',
#   #                                       zip: '80515',
#   #                                       phone: '6102021418',
#   #                                       description: 'I am a great pet dad.')
#   #   end
#   #
#   #   describe "when I visit the favorites index page" do
#   #     it "I see a section that lists all pets with at least one application" do
#   #       visit '/favorites'
#   #
#   #       within '#favorite-pets' do
#   #         expect(page).to have_content(@pet_1.name)
#   #         expect(page).to have_css("img[src*='#{@pet_1.image}']")
#   #
#   #         expect(page).to have_content(@pet_2.name)
#   #         expect(page).to have_css("img[src*='#{@pet_2.image}']")
#   #       end
#   #     end
#   #
#   #     xit "I can click a pet name to visit the pet show page" do
#   #       visit '/favorites'
#   #
#   #       within "#favorite-pets" do
#   #         click_link "#{@pet_1.name}"
#   #         expect(current_path).to eq("/pets/#{@pet_1.id}")
#   #       end
#   #
#   #       visit '/favorites'
#   #
#   #       within "#favorite-pets" do
#   #         click_link "#{@pet_2.name}"
#   #         expect(current_path).to eq("/pets/#{@pet_1.id}")
#   #       end
#   #     end
#   #   end
#   end
# end
