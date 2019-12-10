class PetApplicationsController < ApplicationController
  def update

    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])

    pet_application = PetApplication.where(pet_id: pet.id).where(application_id: application.id).first

    pet.update!(adoptable: false)
    pet_application.update!(approved: true)

    redirect_to "/pets/#{pet.id}"
  end
end
