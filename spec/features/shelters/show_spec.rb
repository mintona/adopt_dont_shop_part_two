require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a shelter show page" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                address: "123 Arapahoe Ave",
                                city: "Boulder",
                                state: "CO",
                                zip: "80301")

      @shelter_2 = Shelter.create(name: "Denver Shelter",
                                address: "345 Blake St",
                                city: "Denver",
                                state: "CO",
                                zip: "80220")
    end

    it "I can see that shelters info" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.zip)

      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_2.address)

      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_2.address)
      expect(page).to have_content(@shelter_2.city)
      expect(page).to have_content(@shelter_2.state)
      expect(page).to have_content(@shelter_2.zip)

      expect(page).to_not have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_1.address)

    end

    it "has link to shelters pets page" do
      visit "/shelters/#{@shelter_1.id}"

      click_on 'View Pets'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    end

    it "shows a list of reviews for that shelter" do
      visit "/shelters/#{@shelter_1.id}"

      review_1 = Review.create!(title: "Great shelter!",
                                rating: 5,
                                content: "I got the best lil pup from this place and the staff was super helpful!",
                                image: "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg",
                                shelter: @shelter_1)
require "pry"; binding.pry
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_content(review_1.image)
    end
  end
end
