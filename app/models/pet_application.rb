class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def toggle_approved
    toggle!(:approved)
  end
end
