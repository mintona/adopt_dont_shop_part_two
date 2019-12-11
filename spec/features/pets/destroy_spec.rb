require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "I can delete a pet" do
    before(:each) do
      shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      description = "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!"
      name = "Alex"
      age = "10"
      sex = "Male"
      @pet_1 = shelter_1.pets.create!(name: name,
                                      image: image,
                                      approximate_age: age,
                                      sex: sex,
                                      description: description)
    end

    it "by clicking the delete pet link to remove pet from the pets index" do
      visit '/pets'

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_css("img[src*='#{@pet_1.image}']")

      visit "/pets/#{@pet_1.id}"

      click_button 'Delete Pet'

      expect(current_path).to eq('/pets')

      expect(page).to_not have_content(@pet_1.name)
      expect(page).to_not have_content(@pet_1.image)
      expect(page).to_not have_content(@pet_1.approximate_age)
      expect(page).to_not have_content(@pet_1.sex)
    end

    it "and if it was favorited it is removed from the favorites list" do
      visit "/pets/#{@pet_1.id}"

      click_button 'Add to Favorite Pets'

      expect(page).to have_content('Favorite Pets: 1')

      click_button 'Delete Pet'

      expect(page).to have_content('Favorite Pets: 0')
    end

    it "if it does not have an approved application" do
      application_1 = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')

      application_2 = Application.create!(name: 'Ali Vermeil',
                                        address: '100 Larimer St',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip: '80211',
                                        phone: '3309078495',
                                        description: 'I am a great pet mom and my animal just got hit by a car.')

      @pet_1.applications << application_1
      @pet_1.applications << application_2

      PetApplication.all.first.toggle_approved

      expect(@pet_1.approved_application?).to eq(true)

      visit "/pets/#{@pet_1.id}"

      click_button 'Delete Pet'

      expect(page).to have_content("#{@pet_1.name} has an approved application and cannot be deleted.")
    end
  end
end
