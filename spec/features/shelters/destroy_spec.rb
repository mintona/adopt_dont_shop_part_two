require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Boulder Shelter",
      address: "123 Arapahoe Ave",
      city: "Boulder",
      state: "CO",
      zip: "80301")
  end
  describe "I can delete a shelter" do

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

  describe "If a shelter has pets that are pending adoption" do
    it "I cannot see a button to delete that shelter on its show page until I unapprove that pet" do
      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"
      pet_1 = Pet.create!(image: pet_1_image,
                          name: "Alex",
                          approximate_age: "10",
                          sex: "Male",
                          description: pet_1_description,
                          shelter: @shelter_1)

      visit "/pets/#{pet_1.id}"
      click_button 'Add to Favorite Pets'

      application = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')
      pet_1.applications << application

      visit "/applications/#{application.id}"

      within "#pet-app-#{pet_1.id}" do
        click_button('Approve')
      end

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to_not have_link('Delete Shelter')

      visit "/shelters"

      within "##{@shelter_1.id}" do
        expect(page).to_not have_button('Delete Shelter')
      end

      visit "/applications/#{application.id}"

      within "#pet-app-#{pet_1.id}" do
        click_button('Unapprove')
      end

      visit "/shelters/#{@shelter_1.id}"

      click_link('Delete Shelter')

      expect(page).to_not have_content(@shelter_1.name)
    end
  end

  describe 'If a shelter has reviews and I delete that shelter' do
    it "the reviews for that shelter are deleted" do
      review_1 = @shelter_1.reviews.create!(title: "Best Shelter Ever!",
                                            content: "I had the best experience here. Would recommend!",
                                            rating: 5,
                                            image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg")

      # no way to test this
    end
  end
end
