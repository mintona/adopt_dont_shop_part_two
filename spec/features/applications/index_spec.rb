require 'rails_helper'

RSpec.describe "As a visitor" do
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

    pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
    pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
    @pet_2 = Pet.create(image: pet_2_image,
                        name: "Marley",
                        approximate_age: "2",
                        sex: "Female",
                        description: pet_2_description,
                        shelter: @shelter_1)

    pets = [@pet_1, @pet_2]

    pets.each do |pet|
      visit "/pets/#{pet.id}"
      click_button 'Add to Favorite Pets'
    end

    @application = Application.create!(name: 'Jordan Holtkamp',
                                      address: '123 Main St',
                                      city: 'Lafayette',
                                      state: 'CO',
                                      zip: '80515',
                                      phone: '6102021418',
                                      description: 'I am a great pet dad.')

    @application_2 = Application.create!(name: 'Ali Vermeil',
                                      address: '100 Larimer St',
                                      city: 'Denver',
                                      state: 'CO',
                                      zip: '80211',
                                      phone: '3309078495',
                                      description: 'I am a great pet mom and my animal just got hit by a car.')
    @pet_1.applications << @application
    @pet_2.applications << @application
    @pet_1.applications << @application_2
  end

  describe "When I visit a pet show page" do
    describe "When I click the link to view all applications" do
      it "I see a list of all the names of applicants for the pet" do
        visit "/pets/#{@pet_1.id}"

        click_button "View all applications for #{@pet_1.name}"

        expect(current_path).to eq("/pets/#{@pet_1.id}/applications")

        expect(page).to have_link(@application.name)
        expect(page).to have_link(@application_2.name)

        visit "/pets/#{@pet_2.id}"

        click_button "View all applications for #{@pet_2.name}"

        expect(page).to have_link(@application.name)
        expect(page).to_not have_link(@application_2.name)

      end

      it "I can click on any applicant's name to visit their application show page" do
        visit "/pets/#{@pet_1.id}/applications"

        click_link (@application.name)

        expect(current_path).to eq("/applications/#{@application.id}")

        visit "/pets/#{@pet_1.id}/applications"

        click_link (@application_2.name)

        expect(current_path).to eq("/applications/#{@application_2.id}")
      end
    end
  end
end
