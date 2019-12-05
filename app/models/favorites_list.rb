class FavoritesList
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(pet_id)
    @contents[pet_id.to_s] = count_of(pet_id) + 1
  end

  def count_of(pet_id)
    @contents[pet_id.to_s].to_i
  end

  def has_pet?(pet_id)
    @contents.keys.include?(pet_id.to_s)
  end
end
