require 'rails_helper'

RSpec.describe Application, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone}
    it {should validate_presence_of :description}
  end

  describe 'relationships' do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe "model methods" do
    before(:each) do
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

      application = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')

      application_2 = Application.create!(name: 'Ali Vermeil',
                                        address: '100 Larimer St',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip: '80211',
                                        phone: '3309078495',
                                        description: 'I am a great pet mom and my animal just got hit by a car.')
      @pet_1.applications << application
      @pet_2.applications << application
      @pet_1.applications << application_2
    end

    describe "#find_applications" do
      it "finds all applications given a pet id" do
        expect(Application.find_applications(@pet_1.id).count).to eq(2)
        expect(Application.find_applications(@pet_2.id).count).to eq(1)
      end
    end
  end
end
