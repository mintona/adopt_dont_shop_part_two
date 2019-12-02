require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can update the information of an existing shelter" do
    original_name = "Boulder Shelter"
    original_address = "123 Arapahoe Ave"
    original_city = "Boulder"
    original_state = "CO"
    original_zip = "80301"

    shelter_1 = Shelter.create(name: original_name,
                              address: original_address,
                              city: original_city,
                              state: original_state,
                              zip: original_zip)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(original_name)
    expect(page).to have_content(original_address)
    expect(page).to have_content(original_city)
    expect(page).to have_content(original_state)
    expect(page).to have_content(original_zip)

    click_link 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    expect(find_field('Name').value).to eq(original_name)
    expect(find_field('Address').value).to eq(original_address)
    expect(find_field('City').value).to eq(original_city)
    expect(find_field('State').value).to eq(original_state)
    expect(find_field('Zip').value).to eq(original_zip)

    new_name = "The Greatest Shelter Ever"
    new_zip = "80304"

    fill_in 'Name', with: new_name
    fill_in 'Zip', with: new_zip

    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to_not have_content(original_name)
    expect(page).to_not have_content(original_zip)

    expect(page).to have_content(new_name)
    expect(page).to have_content(original_address)
    expect(page).to have_content(original_city)
    expect(page).to have_content(original_state)
    expect(page).to have_content(new_zip)
  end
end
