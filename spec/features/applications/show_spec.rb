require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
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
  end

  describe 'When I visit an applications show page' do
    it "shows all of the information for that application" do
      visit '/applications/new'

      application = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')


      @pet_1.applications << application
      # within "#pet-#{@pet_1.id}" do
      #   check 'selected_pets_'
      # end
      #
      # fill_in 'Name', with: 'Ali Vermeil'
      # fill_in 'Address', with: '100 Blake Street'
      # fill_in 'City', with: 'Denver'
      # fill_in 'State', with: 'CO'
      # fill_in 'Zip', with: '80211'
      # fill_in 'Phone', with: '3309078495'
      # fill_in 'Description', with: 'We are a nice animal loving family and our cat just died.'
      #
      # click_button 'Submit Application'

      # thinking the only way to visit the application show page dynamically would be to create an application, save it to the variable and then use the id of it

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip)
      expect(page).to have_content(application.phone)
      expect(page).to have_content(application.description)

      within "#pets-applied-for" do
        expect(page).to have_link("#{@pet_1.name}")
        expect(page).to_not have_link("#{@pet_2.name}")
      end
    end
  end
end