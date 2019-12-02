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

    it "I click the delete pet link to remove pet from the pets index" do
      visit '/pets'

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_css("img[src*='#{@pet_1.image}']")

      visit "/pets/#{@pet_1.id}"

      click_on 'Delete Pet'

      expect(current_path).to eq('/pets')

      expect(page).to_not have_content(@pet_1.name)
      expect(page).to_not have_content(@pet_1.image)
      expect(page).to_not have_content(@pet_1.approximate_age)
      expect(page).to_not have_content(@pet_1.sex)
    end
  end
end
