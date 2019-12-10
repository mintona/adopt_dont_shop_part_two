require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image}
    it { should validate_presence_of :name}
    it { should validate_presence_of :approximate_age}
    it { should validate_presence_of :sex}
    it { should validate_presence_of :shelter}
    it { should validate_presence_of :description}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe "model methods" do
    before :each do
      @shelter_1 = Shelter.create(name: "Boulder Shelter",
                                  address: "123 Arapahoe Ave",
                                  city: "Boulder",
                                  state: "CO",
                                  zip: "80301")

      pet_1_image = "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg"
      @pet_1 = @shelter_1.pets.create!(name: "Alex",
                                      image: pet_1_image,
                                      approximate_age: "10",
                                      sex: "Male",
                                      description: "I am a loveable, snuggly, cat! If you are anti-snuggle, look elsewhere. I want to be pet at all times!")

      pet_2_image = "https://images.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg"
      @pet_2 = @shelter_1.pets.create!(name: "Pea",
                                        approximate_age: "1.5",
                                        sex: "Male",
                                        description: "I'm a peacock!",
                                        image: pet_2_image)

      pet_3_image = "https://images.pexels.com/photos/1076758/pexels-photo-1076758.jpeg"
      @pet_3 = @shelter_1.pets.create!(name: "Jelly",
                                    approximate_age: "3",
                                    sex: "Female",
                                    description: "Watch out, I sting!",
                                    image: pet_3_image)
    end

    it "can count total pets" do
      expect(Pet.pet_count).to eq(3)
    end

    it "can sort pets by adoption status" do
      pets = @shelter_1.pets
      all_adoptable = pets.all? { |pet| pet.adoptable }
      expect(all_adoptable).to eq true
      expect(pets.first).to eq(@pet_1)

      @pet_1.update(adoptable: false)
      @pet_3.update(adoptable: false)

      sorted_pets = @shelter_1.pets.sort_by_adoption_status
      expect(sorted_pets.first).to eq(@pet_2)
    end

    describe "#applied_for" do
      it "can find pets with applications" do
        application = Application.create!(name: 'Jordan Holtkamp',
                                          address: '123 Main St',
                                          city: 'Lafayette',
                                          state: 'CO',
                                          zip: '80515',
                                          phone: '6102021418',
                                          description: 'I am a great pet dad.')

        application_2 = Application.create!(name: 'Ali Vermeil',
                                          address: '123 Soutb St',
                                          city: 'Boulder',
                                          state: 'CO',
                                          zip: '80301',
                                          phone: '7158759903',
                                          description: 'I have a great yard for dogs!')

        @pet_1.applications << application
        @pet_1.applications << application_2
        @pet_2.applications << application

        pets_with_applications = Pet.applied_for.to_a

        expect(pets_with_applications.length).to eq(2)
        expect(pets_with_applications.include?(@pet_1)).to eq(true)
        expect(pets_with_applications.include?(@pet_2)).to eq(true)
        expect(pets_with_applications.include?(@pet_3)).to eq(false)
      end
    end

    describe "#applicant_name" do
      it "can find the name of the approved applicant" do

        application = Application.create!(name: 'Jordan Holtkamp',
                                          address: '123 Main St',
                                          city: 'Lafayette',
                                          state: 'CO',
                                          zip: '80515',
                                          phone: '6102021418',
                                          description: 'I am a great pet dad.')

        @pet_1.applications << application

        pet_application = PetApplication.where(pet_id: @pet_1.id).where(application_id: application.id).first

        pet_application.toggle!(:approved)

        expect(@pet_1.approved_applicant_name).to eq(application.name)
      end
    end

    describe "#approved_application?" do
      it "can find out if the pet has any approved applications" do
        application = Application.create!(name: 'Jordan Holtkamp',
                                          address: '123 Main St',
                                          city: 'Lafayette',
                                          state: 'CO',
                                          zip: '80515',
                                          phone: '6102021418',
                                          description: 'I am a great pet dad.')

        @pet_1.applications << application

        pet_application = PetApplication.where(pet_id: @pet_1.id).where(application_id: application.id).first

        expect(@pet_1.approved_application?).to eq(false)

        pet_application.toggle!(:approved)

        expect(@pet_1.approved_application?).to eq(true)
      end
    end

    describe "#toggle_adoptable" do
      it "can change a pets adoptable from true to false or false to true " do
        expect(@pet_1.adoptable).to eq(true)

        @pet_1.toggle_adoptable

        expect(@pet_1.adoptable).to eq(false)

        @pet_1.toggle_adoptable

        expect(@pet_1.adoptable).to eq(true)
      end
    end
  end
end
