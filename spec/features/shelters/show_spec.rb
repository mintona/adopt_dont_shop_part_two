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
            review_1 = Review.create!(title: "Great shelter!",
                                      rating: 5,
                                      content: "I got the best lil pup from this place and the staff was super helpful!",
                                      image: "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg",
                                      shelter: @shelter_1)

            review_2 = Review.create!(title: "Cute dogs!",
                                      rating: 4,
                                      content: "I got the cutest pit bull, but the front desk lady was kind of mean.",
                                      image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg",
                                      shelter: @shelter_1)

            review_3 = Review.create!(title: "The best!",
                                      rating: 4,
                                      content: "I love kitty cats",
                                      image: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat3.jpg",
                                      shelter: @shelter_2)

      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{review_1.id}" do
        expect(page).to have_content(review_1.title)
        expect(page).to have_content(review_1.rating)
        expect(page).to have_content(review_1.content)
        expect(page).to have_css("img[src*='#{review_1.image}']")
      end

      within "#review-#{review_2.id}" do
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.rating)
        expect(page).to have_content(review_2.content)
        expect(page).to have_css("img[src*='#{review_2.image}']")
      end

      expect(page).to_not have_css("#review-#{review_3.id}")
    end

    it "shows me statistics for that shelter" do
      review_1 = Review.create!(title: "Great shelter!",
                                rating: 2,
                                content: "I got the best lil pup from this place and the staff was super helpful!",
                                image: "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg",
                                shelter: @shelter_1)

      review_2 = Review.create!(title: "Cute dogs!",
                                rating: 4,
                                content: "I got the cutest pit bull, but the front desk lady was kind of mean.",
                                image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg",
                                shelter: @shelter_1)

      review_3 = Review.create!(title: "The best!",
                                rating: 4,
                                content: "I love kitty cats",
                                image: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat3.jpg",
                                shelter: @shelter_1)

      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

      pet_1 = Pet.create!(image: pet_1_image,
                          name: "Alex",
                          approximate_age: "10",
                          sex: "Male",
                          shelter: @shelter_1,
                          description: pet_1_description)

      pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
      pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
      pet_2 = Pet.create!(image: pet_2_image,
                          name: "Marley",
                          approximate_age: "8 weeks",
                          sex: "Female",
                          shelter: @shelter_1,
                          description: pet_2_description)

      pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
      pet_3_description = "I'm a jelly fish! Watch out, I sting!"
      pet_3 = Pet.create!(image: pet_3_image,
                          name: "Peanut",
                          approximate_age: "2",
                          sex: "Female",
                          shelter: @shelter_2,
                          description: pet_3_description)

      application_1 = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')
      pet_1.applications << application_1

      application_2 = Application.create!(name: 'Ali Vermeil',
                                        address: '123 Blake St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '3309078495',
                                        description: 'I am a great pet mom.')
      pet_3.applications << application_2


      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content('Average Rating: 3.33 / 5')
      expect(page).to have_content('Number of pets at this shelter: 2')
      expect(page).to have_content('Number of applications on file for pets at this shelter: 1')
    end
  end
end
