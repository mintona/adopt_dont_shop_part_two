class Pet < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :shelter
  validates_presence_of :description

  def self.pet_count
    count
  end

  def self.sort_by_adoption_status
    order(:adoptable).reverse
  end
end
