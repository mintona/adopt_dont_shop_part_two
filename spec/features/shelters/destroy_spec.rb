require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "I can delete a shelter" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                          address: "123 Arapahoe Ave",
                          city: "Boulder",
                          state: "CO",
                          zip: "80301")
    end

    it "if it has no pets" do
      expect(@shelter_1.pets.empty?).to eq(true)

      visit "/shelters"

      expect(page).to have_content(@shelter_1.name)

      visit "/shelters/#{@shelter_1.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter_1.name)
    end

    it "if it has pets" do
      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"
      pet_1 = Pet.create!(image: pet_1_image,
                          name: "Alex",
                          approximate_age: "10",
                          sex: "Male",
                          description: pet_1_description,
                          shelter: @shelter_1)

      expect(@shelter_1.pets.empty?).to eq(false)

      visit "/shelters"

      expect(page).to have_content(@shelter_1.name)

      visit "/shelters/#{@shelter_1.id}"

      click_link 'Delete Shelter'

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter_1.name)
    end
  end
end
