require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "I can remove a pet from my favorite pets" do
    before :each do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      @pet_1 = @shelter_1.pets.create!(name: "Alex",
                                      image: pet_1_image,
                                      approximate_age: "10",
                                      sex: "Male",
                                      description: "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!")

      pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
      pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
      @pet_2 = Pet.create(image: pet_2_image,
                          name: "Marley",
                          approximate_age: "2",
                          sex: "Female",
                          description: pet_2_description,
                          shelter: @shelter_1)

    end

    describe "by clicking on the remove from favorite pets button on the pets show page" do
      it "displays a message indicating the pet was removed" do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to Favorite Pets'

        click_button 'Remove from Favorite Pets'

        expect(current_path).to eq("/pets/#{@pet_1.id}")

        expect(page).to have_content("#{@pet_1.name} has been removed from your Favorite Pets.")
      end

      it "changes the remove from favorites button to add to favorites" do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to Favorite Pets'

        click_button 'Remove from Favorite Pets'

        expect(page).to have_button('Add to Favorite Pets')
      end

      it "decrements the favorites indicator by 1" do
        visit "/pets/#{@pet_1.id}"

        click_button 'Add to Favorite Pets'

        expect(page).to have_content('Favorite Pets: 1')

        click_button 'Remove from Favorite Pets'

        expect(page).to have_content('Favorite Pets: 0')
      end
    end

    describe 'from the favorites index page' do
      before :each do
        visit "/pets/#{@pet_1.id}"
        click_button 'Add to Favorite Pets'
        visit "/pets/#{@pet_2.id}"
        click_button 'Add to Favorite Pets'
      end

      it 'I can click a link to delete each pet' do
        visit '/favorites'

        within "#pet-#{@pet_1.id}" do
          click_button 'Remove from Favorite Pets'
          expect(current_path).to eq('/favorites')
        end

        expect(page).to_not have_css("#pet-#{@pet_1.id}")
        expect(page).to_not have_css("img[src*='#{@pet_1.image}']")

        within "#pet-#{@pet_2.id}" do
          click_button 'Remove from Favorite Pets'
          expect(current_path).to eq('/favorites')
        end

        expect(page).to_not have_css("#pet-#{@pet_2.id}")
        expect(page).to_not have_css("img[src*='#{@pet_2.image}']")
      end
    end
  end
end
