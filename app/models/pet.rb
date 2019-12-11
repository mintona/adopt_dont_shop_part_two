class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
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

  def self.applied_for
    Pet.distinct.joins(:pet_applications)
  end

  def approved_applicant_name
    Application.joins(:pet_applications).where("approved = true AND pet_id = #{self.id}").first.name
  end

  def approved_application?
    applications = Application.joins(:pet_applications).where("approved = true AND pet_id = #{self.id}")
    !applications.empty?
  end

  def toggle_adoptable
    toggle!(:adoptable)
  end
end
