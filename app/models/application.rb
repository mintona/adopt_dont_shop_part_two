class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone
  validates_presence_of :description

  def self.find_applications(pet_id)
    Application.select('applications.*').joins(:pets).where("pets.id = #{pet_id}")
  end
end