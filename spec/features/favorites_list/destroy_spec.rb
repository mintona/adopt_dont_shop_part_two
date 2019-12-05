require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "I can remove a pet from my favorite pets" do
    describe "by clicking on the remove from favorite pets button" do
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

      end

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
  end
end
