require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "I can delete a review" do
    before :each do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      @review_1 = @shelter_1.reviews.create!(title: "Best Shelter Ever!",
                                            content: "I had the best experience here. Would recommend!",
                                            rating: 5,
                                            image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg")

      @review_2 = @shelter_1.reviews.create!(title: "Love this place!",
                                            content: "They have the cutest pets you've ever seen and the best staff.",
                                            rating: 4,
                                            image: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat3.jpg")
    end

    it "by clicking on the delete button next to the review" do
      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_1.id}" do
        click_button 'Delete Review'
      end

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to_not have_css("#review-#{@review_1.id}")

      within "#review-#{@review_2.id}" do
        click_button 'Delete Review'
      end

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to_not have_css("#review-#{@review_2.id}")
    end
  end
end
