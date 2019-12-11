class Shelter < ApplicationRecord
  #does this need to be tested?
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def pets_pending?
    pets.any? {|pet| !pet.adoptable }
  end
end
