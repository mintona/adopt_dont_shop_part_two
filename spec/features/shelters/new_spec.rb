require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "I can add a new shelter" do

    visit '/shelters'

    expect(page).to_not have_content('Lafayette Shelter')

    click_link "Add Shelter"

    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content('Add a Shelter')

    fill_in 'Name', with: 'Lafayette Shelter'
    fill_in 'Address', with: '789 South Public Rd'
    fill_in 'City', with: 'Lafayette'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: "80516"

    click_on 'Add Shelter'

    expect(current_path).to eq('/shelters')

    expect(page).to have_content('The shelter has been created!')
    expect(page).to have_content('Lafayette Shelter')
  end

  describe "If I do not fill in a field" do
    it "gives me a flash message letting me know which field I missed" do
      visit "/shelters/new"

      fill_in 'Name', with: 'Lafayette Shelter'
      fill_in 'Address', with: '789 South Public Rd'
      fill_in 'City', with: 'Lafayette'
      fill_in 'State', with: 'CO'

      click_button 'Add Shelter'

      expect(page).to have_button("Add Shelter")
      expect(page).to have_content("Zip can't be blank")
    end
  end
end
