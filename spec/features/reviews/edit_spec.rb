require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                address: "123 Arapahoe Ave",
                                city: "Boulder",
                                state: "CO",
                                zip: "80301")

    @review_1_original_title = "Great shelter!"
    @review_1_original_rating = 3
    @review_1_original_content = "I got the best lil pup from this place and the staff was super helpful!"
    @review_1_original_image = "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg"

    @review_1 = Review.create!(title: @review_1_original_title,
                               rating: @review_1_original_rating,
                               content: @review_1_original_content,
                               image: @review_1_original_image,
                               shelter: @shelter_1)

    @review_2 = Review.create!(title: "Cute dogs!",
                               rating: 4,
                               content: "I got the cutest pit bull, but the front desk lady was kind of mean.",
                               image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg",
                               shelter: @shelter_1)
  end

  describe 'When I am on a shelter show page' do
    it 'shows a link to edit each review that takes me to that review edit page' do
      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_1.id}" do
        click_button 'Update Review'
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")
      end

      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_2.id}" do
        click_button 'Update Review'
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_2.id}/edit")
      end
    end
  end

  describe 'when I click the update review button for a review' do
    describe 'it takes me to the review edit page' do
      it 'updates the review with the info I enter and takes me back to shelter show page' do

        visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

        expect(find_field('Title').value).to eq(@review_1_original_title)
        expect(find_field('Rating').value).to eq(@review_1_original_rating.to_s)
        expect(find_field('Content').value).to eq(@review_1_original_content)
        expect(find_field('Image').value).to eq(@review_1_original_image)

        new_title = "Nice People!"
        new_rating = 4
        new_content = "Staff was very helpful"

        fill_in 'Title', with: new_title
        select new_rating, from: :rating
        fill_in 'Content', with: new_content

        click_button 'Update Review'

        expect(current_path).to eq("/shelters/#{@shelter_1.id}")
        expect(page).to have_content('Your review has been updated.')

        within "#review-#{@review_1.id}" do
          expect(page).to have_content(new_title)
          expect(page).to have_content(new_rating)
          expect(page).to have_content(new_content)
          expect(page).to have_css("img[src*='#{@review_1_original_image}']")

          expect(page).to_not have_content(@review_1_original_title)
          expect(page).to_not have_content(@review_1_original_rating)
          expect(page).to_not have_content(@review_1_original_content)
        end
      end

      it "shows an error if I leave a required field blank" do
        new_title = ""
        flash = "Please fill out all required fields."

        visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

        expect(find_field('Title').value).to eq(@review_1_original_title)
        expect(find_field('Rating').value).to eq(@review_1_original_rating.to_s)
        expect(find_field('Content').value).to eq(@review_1_original_content)
        expect(find_field('Image').value).to eq(@review_1_original_image)

        fill_in 'Title', with: new_title

        click_button 'Update Review'

        expect(page).to have_button('Update Review')
        expect(page).to have_content(flash)
      end
    end
  end
end
