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
  end
end
