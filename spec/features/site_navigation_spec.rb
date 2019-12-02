require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit any page on the site" do
    before(:each) do
      @shelter = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      description = "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!"
      name = "Alex"
      age = "10"
      sex = "Male"
      @pet = @shelter.pets.create!(name: name,
                                      image: image,
                                      approximate_age: age,
                                      sex: sex,
                                      description: description)

    end

    it "I see a link to the pet index and shelter index" do
      paths = ['/',
      '/shelters',
      '/shelters/new',
      "/shelters/#{@shelter.id}",
      '/shelters',
      "/shelters/#{@shelter.id}/edit",
      "/shelters/#{@shelter.id}",
      "/shelters/#{@shelter.id}",
      '/pets',
      "/pets/#{@pet.id}",
      "/pets/#{@pet.id}/edit",
      "/pets/#{@pet.id}",
      "/pets/#{@pet.id}",
      "/shelters/#{@shelter.id}/pets",
      "/shelters/#{@shelter.id}/pets/new",
      "/shelters/#{@shelter.id}/pets"]

      paths.each do |path|
        visit path
        within(:css, 'nav') do
          click_link('All Pets')
          visit path
          click_link('All Shelters')
        end
      end
    end
  end
end
