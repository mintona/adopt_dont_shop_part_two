require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                address: "123 Arapahoe Ave",
                                city: "Boulder",
                                state: "CO",
                                zip: "80301")
  end
  describe "when I visit the a shelter show page" do
    it "I can click the link to fill out a form to add a new review" do

      title = "Great shelter!"
      rating = 5
      content = "I got the best lil pup from this place and the staff was super helpful!"
      image = "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg"

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to_not have_content(title)
      expect(page).to_not have_content(content)

      expect(page).to_not have_content("#{rating} / 5 paws")

      click_button 'Add Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      expect(page).to have_content("Add a Review")

      fill_in 'Title', with: title
      select rating, from: :rating
      fill_in 'Content', with: content
      fill_in 'Image', with: image

      click_button 'Submit Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content(title)
      expect(page).to have_content("#{rating} / 5 paws")
      expect(page).to have_content(content)
      expect(page).to have_css("img[src*='#{image}']")
      expect(page).to have_content("Your review has been posted.")
    end
  end

  describe "When I am on the new review page" do
    it "gives a flash message if I do not fill in all required fields" do

      title = "Great shelter!"
      rating = 5
      content = "I got the best lil pup from this place and the staff was super helpful!"
      image = "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg"

      flash = "Please fill out all required fields."
      visit "/shelters/#{@shelter_1.id}/reviews/new"

      select rating, from: :rating
      fill_in 'Content', with: content
      fill_in 'Image', with: image

      click_button 'Submit Review'

      expect(page).to have_button('Submit Review')
      expect(page).to have_content(flash)

      select rating, from: :rating
      fill_in 'Content', with: content
      fill_in 'Image', with: image

      click_button 'Submit Review'

      expect(page).to have_button('Submit Review')
      expect(page).to have_content(flash)
    end

    it 'allows me to post a review without an image' do
      title = "Great shelter!"
      rating = 5
      content = "I got the best lil pup from this place and the staff was super helpful!"
      flash = "Your review has been posted."

      visit "/shelters/#{@shelter_1.id}/reviews/new"

      fill_in 'Title', with: title
      select rating, from: :rating
      fill_in 'Content', with: content

      click_button 'Submit Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content(title)
      expect(page).to have_content(rating)
      expect(page).to have_content(content)
      expect(page).to have_content("Your review has been posted.")
    end
  end
end
