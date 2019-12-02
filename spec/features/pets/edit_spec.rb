require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a pet show page" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      @original_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      @original_description = "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!"
      @original_name = "Alex"
      @original_age = "10"
      @original_sex = "Male"
      @pet_1 = @shelter_1.pets.create!(name: @original_name,
                                      image: @original_image,
                                      approximate_age: @original_age,
                                      sex: @original_sex,
                                      description: @original_description)
    end

    it "has a link to update that pet" do
      visit "/pets/#{@pet_1.id}"

      click_on 'Update Pet'

      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
      
      expect(page).to have_content("Update #{@pet_1.name}'s Information")
    end

    describe "I click the update pet link to" do
      describe "fill out the form to update" do
        it "any of the pets information" do

          visit "/pets/#{@pet_1.id}/edit"
          
          expect(find_field('Name').value).to eq(@original_name)
          expect(find_field('Image').value).to eq(@original_image)
          expect(find_field('Approximate age').value).to eq(@original_age)
          expect(find_field('Sex').value).to eq(@original_sex)

          new_name = "Amber"
          new_age = "9"
          
          fill_in 'Name', with: new_name
          fill_in 'Approximate age', with: new_age
          select 'Female', from: :sex

          click_on 'Update Pet'

          expect(current_path).to eq("/pets/#{@pet_1.id}")

          expect(page).to have_content(new_name)
          expect(page).to_not have_content(@original_name)

          expect(page).to have_content(new_age)
          expect(page).to_not have_content(@original_age)

          expect(page).to have_content('Female')
          expect(page).to_not have_content('Male')

          expect(page).to have_content(@original_description)
          expect(page).to have_css("img[src*='#{@original_image}']")
        end
      end
    end
  end
end
