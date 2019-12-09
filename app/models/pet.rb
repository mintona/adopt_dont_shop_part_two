class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

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
  #
  # def self.applied_for
  #   pet_ids = PetApplication.pluck(:pet_id).uniq
  #   Pet.where(id: pet_ids)
  # end


  def self.applied_for
    Pet.distinct.joins(:pet_applications)
  end
end
