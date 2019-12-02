require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelters pets index" do
    before (:each) do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")
    end

    describe "I see a link to add a new pet to the shelter" do
      it "when the shelter has no pets" do
        visit "shelters/#{@shelter_1.id}/pets"

        click_link "Add Pet"

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
      end

      it "when the shelter has pets" do
        peacock_image = "https://images.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg"

        peacock = @shelter_1.pets.create!(name: "Pea",
                            approximate_age: "1.5",
                            sex: "Male",
                            description: "I'm a peacock!",
                            image: peacock_image)

        visit "/shelters/#{@shelter_1.id}/pets"

        expect(page).to have_content(peacock.name)

        click_link "Add Pet"

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
      end
    end

    describe "I click the add pet link to" do
      it "fill out a form to add a new adoptable pet to that shelter" do
        pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
        image = pet_1_image
        name = "Alex"
        approximate_age = "10"
        sex = "Male"
        shelter = @shelter_1
        description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

        visit "/shelters/#{@shelter_1.id}/pets/new"

        expect(page).to have_content('Add a Pet')

        fill_in 'Image', with: image
        fill_in 'Name', with: name
        fill_in 'Description', with: description
        fill_in 'Approximate age', with: approximate_age
        select 'Male', from: :sex

        click_on 'Add Pet'

        pet_1 = @shelter_1.pets.last

        expect(pet_1.adoptable).to eq true

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

        expect(page).to have_content(name)
        expect(page).to have_content(approximate_age)
        expect(page).to have_content(sex)
        expect(page).to have_css("img[src*='#{pet_1_image}']")
      end
    end
  end
end
