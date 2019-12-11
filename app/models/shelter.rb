class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def pets_pending?
    count = pets.where(adoptable: false).count
    if count > 0
      true
    else
      false
    end
  end

  def average_rating
    reviews.average(:rating).to_f
  end

  def pet_count
    pets.count
  end

  def number_of_applications
    Application.joins(:pet_applications).joins(:pets).where("pets.shelter_id = #{self.id}").count
  end
end
