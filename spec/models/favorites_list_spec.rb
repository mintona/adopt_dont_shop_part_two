require 'rails_helper'

RSpec.describe FavoritesList do
  before :each do
    @favorites_list = FavoritesList.new({})
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
  end
  describe "#total_count" do
    it "can calculate the total number of favorited pets" do
      favorites_list = FavoritesList.new({
        "1" => 1,
        "2" => 1
        })

      expect(favorites_list.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "can add a pet to its contents" do
      favorites_list = FavoritesList.new({
        "1" => 1
        })

      favorites_list.add_pet(2)

      expected = {'1' => 1, '2' => 1}

      expect(favorites_list.contents).to eq(expected)
    end
  end

  describe "#count_of" do
    it "returns the count of all the pets in the list" do
      favorites_list = FavoritesList.new({})

      expect(favorites_list.count_of(3)).to eq(0)
    end
  end

  describe "#has_pet?" do
    it "can check if a pet is on the favorites list" do
      expect(@favorites_list.has_pet?(@pet_1.id)).to eq(false)
      expect(@favorites_list.has_pet?(@pet_2.id)).to eq(false)

      @favorites_list.add_pet(@pet_1.id)
      @favorites_list.add_pet(@pet_2.id)

      expect(@favorites_list.has_pet?(@pet_1.id)).to eq(true)
      expect(@favorites_list.has_pet?(@pet_2.id)).to eq(true)
    end
  end

  describe "#clear_all" do
    it "can delete all favorites" do
      @favorites_list.add_pet(@pet_1.id)
      @favorites_list.add_pet(@pet_2.id)

      expect(@favorites_list.contents.length).to eq(2)

      @favorites_list.clear_all

      expect(@favorites_list.contents.empty?).to eq(true)
    end
  end

  describe "#remove" do
    it "can remove pet by id" do
      @favorites_list.add_pet(@pet_1.id)
      @favorites_list.add_pet(@pet_2.id)

      expected = @favorites_list.contents.keys.include?(@pet_1.id.to_s && @pet_2.id.to_s)

      expect(expected).to eq(true)

      @favorites_list.remove(@pet_1.id)

      keys = @favorites_list.contents.keys

      expect(keys).to eq([@pet_2.id.to_s])
    end
  end

  describe '#pet_ids' do
    it "can list pet ids of pets in favorites list" do
      @favorites_list.add_pet(@pet_1.id)
      @favorites_list.add_pet(@pet_2.id)

      expect(@favorites_list.pet_ids).to eq([@pet_1.id, @pet_2.id])
    end
  end
end
