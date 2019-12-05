require 'rails_helper'

RSpec.describe FavoritesList do

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
end
