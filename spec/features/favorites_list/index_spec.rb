require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the favorites index page" do
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
    end

    it 'shows all favorited pets' do
      visit '/favorites'

      # have message for no favorite pets yet
      expect(page).to_not have_css("#pet-#{@pet_1.id}")
      expect(page).to_not have_css("#pet-#{@pet_2.id}")

      visit "/pets/#{@pet_1.id}"

      click_button 'Add to Favorite Pets'

      visit '/favorites'

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_css("img[src*='#{@pet_1.image}']")
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end

      visit "/pets/#{@pet_2.id}"

      click_button 'Add to Favorite Pets'

      visit '/favorites'

      within "#pet-#{@pet_2.id}" do
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
    end
  end
end
#   As a visitor
# When I have added pets to my favorites list
# And I visit my favorites index page ("/favorites")
# I see all pets I've favorited
# Each pet in my favorites shows the following information: