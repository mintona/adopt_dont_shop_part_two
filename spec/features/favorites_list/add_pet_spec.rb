require 'rails_helper'

RSpec.describe "When a user adds pets to their favorite list" do
  before(:each) do
    @shelter = Shelter.create(name: "Boulder Shelter",
                              address: "123 Arapahoe Ave",
                              city: "Boulder",
                              state: "CO",
                              zip: "80301")

    image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
    description = "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!"
    @pet = @shelter.pets.create!(name: "Alex",
                                 image: image,
                                 approximate_age: "10",
                                 sex: "Male",
                                 description: description)

  end

  it "displays a message" do
    visit "/pets/#{@pet.id}"

    click_button 'Add to Favorite Pets'

    expect(current_path).to eq("/pets/#{@pet.id}")

    expect(page).to have_content("#{@pet.name} has been added to your Favorite Pets!")
  end

  it "the indicator increments by one" do
    visit "/pets/#{@pet.id}"

    expect(page).to have_content("Favorite Pets: 0")

    click_button 'Add to Favorite Pets'

    expect(page).to have_content("Favorite Pets: 1")
  end
end
