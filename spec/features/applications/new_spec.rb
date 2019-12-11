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
    it "I see my favorites and I am able to select them" do
      visit '/applications/new'

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_unchecked_field('selected_pets_')
          check 'selected_pets_'
          expect(page).to have_checked_field('selected_pets_')
        end

        within "#pet-#{@pet_2.id}" do
          expect(page).to have_unchecked_field('selected_pets_')
          check 'selected_pets_'
          expect(page).to have_checked_field('selected_pets_')
        end
    end

    describe "I can fill out a form to add a new application" do
      it 'I can apply for all of my favorites and get a confirmation message' do
        visit '/applications/new'

        within "#pet-#{@pet_1.id}" do
          check 'selected_pets_'
        end

        within "#pet-#{@pet_2.id}" do
          check 'selected_pets_'
        end

        fill_in 'Name', with: 'Ali Vermeil'
        fill_in 'Address', with: '100 Blake Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80211'
        fill_in 'Phone', with: '3309078495'
        fill_in 'Description', with: 'We are a nice animal loving family and our cat just died.'

        click_button 'Submit Application'

        expect(current_path).to eq('/favorites')

        expect(page).to have_content("You have applied to adopt your selected pets.")

        expect(page).to have_content("You haven't added any pets to your Favorite Pets yet.")

        within "#favorites" do
          expect(page).to_not have_content(@pet_1.name)
          expect(page).to_not have_css("img[src*='#{@pet_1.image}']")

          expect(page).to_not have_content(@pet_2.name)
          expect(page).to_not have_css("img[src*='#{@pet_2.image}']")
        end
      end

      it "I can apply for only some of my favorite pets" do
        visit '/applications/new'

        within "#pet-#{@pet_1.id}" do
          check 'selected_pets_'
        end

        fill_in 'Name', with: 'Ali Vermeil'
        fill_in 'Address', with: '100 Blake Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80211'
        fill_in 'Phone', with: '3309078495'
        fill_in 'Description', with: 'We are a nice animal loving family and our cat just died.'

        click_button 'Submit Application'

        expect(current_path).to eq('/favorites')

        expect(page).to have_content("You have applied to adopt your selected pets.")

        expect(page).to_not have_content("You haven't added any pets to your Favorite Pets yet.")

        within "#favorites" do
          expect(page).to_not have_content(@pet_1.name)
          expect(page).to_not have_css("img[src*='#{@pet_1.image}']")
        end

        expect(page).to have_content(@pet_2.name)
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
      end

      it "I will get an error message if I fail to fill out a required field" do
        visit '/applications/new'

        within "#pet-#{@pet_1.id}" do
          check 'selected_pets_'
        end

        within "#pet-#{@pet_2.id}" do
          check 'selected_pets_'
        end

        fill_in 'Name', with: 'Ali Vermeil'
        fill_in 'Address', with: '100 Blake Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80211'
        fill_in 'Phone', with: '3309078495'

        click_button 'Submit Application'

        expect(page).to have_button('Submit Application')
        expect(page).to have_content("Please fill out all fields.")
      end

      it "I will get an error message if I fill out all fields but fail to select any pets" do

        visit '/applications/new'

        fill_in 'Name', with: 'Ali Vermeil'
        fill_in 'Address', with: '100 Blake Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80211'
        fill_in 'Phone', with: '3309078495'
        fill_in 'Description', with: 'We are a nice animal loving family and our cat just died.'

        click_button 'Submit Application'

        expect(page).to have_button('Submit Application')
        expect(page).to have_content("Please select at least one pet.")
      end

      it "I can click a pets name to be taken to its show page" do
        visit '/applications/new'

        click_link "#{@pet_1.name}"

        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit '/applications/new'

        click_link "#{@pet_2.name}"

        expect(current_path).to eq("/pets/#{@pet_2.id}")
      end
    end
  end
end
