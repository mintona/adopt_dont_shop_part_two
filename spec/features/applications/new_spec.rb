require 'rails_helper'

RSpec.describe 'As a visitor' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Boulder Shelter",
                              address: "123 Arapahoe Ave",
                              city: "Boulder",
                              state: "CO",
                              zip: "80301")

    pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
    pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

    @pet_1 = Pet.create(image: pet_1_image,
                        name: "Alex",
                        approximate_age: "10",
                        sex: "Male",
                        description: pet_1_description,
                        shelter: @shelter_1)

    @shelter_2 = Shelter.create(name: "Denver Shelter",
                              address: "345 Blake St",
                              city: "Denver",
                              state: "CO",
                              zip: "80220")

    pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
    pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
    @pet_2 = Pet.create(image: pet_2_image,
                        name: "Marley",
                        approximate_age: "2",
                        sex: "Female",
                        description: pet_2_description,
                        shelter: @shelter_2)

    pets = [@pet_1, @pet_2]

    pets.each do |pet|
      visit "/pets/#{pet.id}"
      click_button 'Add to Favorite Pets'
    end
  end

  describe 'When I visit the favorites index page' do
    it "I can click the link to make a new application if I have favorites" do
      visit '/favorites'

      click_button 'Apply for Adoption'

      expect(current_path).to eq('/applications/new')

      visit '/favorites'

      click_button 'Remove All Pets from Favorites'

      expect(page).to_not have_button('Apply for Adoption')
    end
  end

  describe 'After I click the link to make a new application' do
    it "I see my favorites I am able to select" do
      visit '/applications/new'
      # save_and_open_page
        check "#{@pet_1.name}"
        check "#{@pet_2.name}"
        save_and_open_page
      # check "#{@pet_1.name}", from: :favorited_pets
      # check "#{@pet_2.name}", from: :favorited_pets
    end

    xit "I can fill out a form to add a new application" do

    end
  end
end