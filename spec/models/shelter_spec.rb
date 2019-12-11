require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
  end

  describe "relationships" do
    it { should have_many :pets}
    it { should have_many :reviews}
  end

  describe 'model methods' do
    describe '#pets_pending?' do
      it 'returns true if any pets in a shelter are pending adoption' do
        @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                    address: "123 Arapahoe Ave",
                                    city: "Boulder",
                                    state: "CO",
                                    zip: "80301")

        pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
        pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

        @pet_1 = Pet.create(image: pet_1_image,
                            name: "Alex",
                            approximate_age: "10",
                            sex: "Male",
                            description: pet_1_description,
                            shelter: @shelter_1)

        pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
        pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
        @pet_2 = Pet.create(image: pet_2_image,
                            name: "Marley",
                            approximate_age: "2",
                            sex: "Female",
                            description: pet_2_description,
                            shelter: @shelter_1)

        pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
        pet_3_description = "I'm a jelly fish! Watch out, I sting!"
        @pet_3 = Pet.create!(image: pet_3_image,
                            name: "Peanut",
                            approximate_age: "2",
                            sex: "Female",
                            description: pet_3_description,
                            shelter: @shelter_1)

        expect(@shelter_1.pets_pending?).to eq(false)

        @shelter_1.pets.first.toggle_adoptable

        expect(@shelter_1.pets_pending?).to eq(true)
      end
    end

    describe '#average_rating' do
      it "gives the average rating of the shelter" do
        shelter_1 = Shelter.create(name: "Boulder Shelter",
                                   address: "123 Arapahoe Ave",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: "80301")

        shelter_2 = Shelter.create(name: "Denver Shelter",
                                   address: "345 Blake St",
                                   city: "Denver",
                                   state: "CO",
                                   zip: "80220")

        review_1 = Review.create!(title: "Great shelter!",
                                 rating: 3,
                                 content: "I got the best lil pup from this place and the staff was super helpful!",
                                 image: "http://rmpuppyrescue.org/images/1052801_529279620453288_1859974512_o%20(1)172x119_2x.jpg",
                                 shelter: shelter_1)

        review_2 = Review.create!(title: "Cute dogs!",
                                 rating: 4,
                                 content: "I got the cutest pit bull, but the front desk lady was kind of mean.",
                                 image: "http://rmpuppyrescue.org/images/spay%20clinic-crop-u1009034_2x.jpg",
                                 shelter: shelter_1)

        review_3 = Review.create!(title: "The best!",
                                 rating: 4,
                                 content: "I love kitty cats",
                                 image: "https://face4pets.org/wp-content/uploads/2015/06/shelter-cat3.jpg",
                                 shelter: shelter_2)

        expect(shelter_1.average_rating).to eq(3.50)
      end
    end

    describe "#pet_count" do
      it "counts the pets at a shelter" do
        shelter_1 = Shelter.create(name: "Boulder Shelter",
                                   address: "123 Arapahoe Ave",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: "80301")

        shelter_2 = Shelter.create(name: "Denver Shelter",
                                   address: "345 Blake St",
                                   city: "Denver",
                                   state: "CO",
                                   zip: "80220")

         pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
         pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

         pet_1 = Pet.create!(image: pet_1_image,
                             name: "Alex",
                             approximate_age: "10",
                             sex: "Male",
                             shelter: shelter_1,
                             description: pet_1_description)

         pet_2_image = "https://images.pexels.com/photos/39317/chihuahua-dog-puppy-cute-39317.jpeg"
         pet_2_description = 'I am the cutest puppy ever! I love to be around kids as long as they do not play too "ruff."'
         pet_2 = Pet.create!(image: pet_2_image,
                             name: "Marley",
                             approximate_age: "8 weeks",
                             sex: "Female",
                             shelter: shelter_1,
                             description: pet_2_description)

        expect(shelter_1.pet_count).to eq(2)
        expect(shelter_2.pet_count).to eq(0)
      end
    end

    describe '#number_of_applications' do
      it "counts the number of applications on file for a shelter" do
        pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
        pet_1_description = "I am a loveable, snuggly, cat! If you are anti snuggle, look elsewhere. I want to be pet at all times!"

        shelter_1 = Shelter.create(name: "Boulder Shelter",
                                   address: "123 Arapahoe Ave",
                                   city: "Boulder",
                                   state: "CO",
                                   zip: "80301")
        pet_1 = Pet.create(image: pet_1_image,
                           name: "Alex",
                           approximate_age: "10",
                           sex: "Male",
                           description: pet_1_description,
                           shelter: shelter_1)

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

        application_3 = Application.create!(name: 'Ali Vermeil',
                                            address: '123 Harvard St',
                                            city: 'Lafayette',
                                            state: 'CO',
                                            zip: '80515',
                                            phone: '3309078495',
                                            description: 'I am a great pet mom.')
        pet_1.applications << application_2

        expect(shelter_1.number_of_applications).to eq(2)
      end
    end
  end
end
