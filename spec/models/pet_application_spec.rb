require 'rails_helper'

RSpec.describe PetApplication, type: :model do

  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe 'model methods' do
    before :each do
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


      @application = Application.create!(name: 'Jordan Holtkamp',
                                        address: '123 Main St',
                                        city: 'Lafayette',
                                        state: 'CO',
                                        zip: '80515',
                                        phone: '6102021418',
                                        description: 'I am a great pet dad.')


      @pet_1.applications << @application

      @pet_application = PetApplication.all.first
    end

    describe "#toggle_approved" do
      it "changes a pet applications approved from false to true or true to false" do
        expect(@pet_application.approved).to eq(false)

        @pet_application.toggle_approved

        expect(@pet_application.approved).to eq(true)

        @pet_application.toggle_approved

        expect(@pet_application.approved).to eq(false)
      end
    end
  end
end
