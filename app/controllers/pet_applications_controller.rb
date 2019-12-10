class PetApplicationsController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])

    pet_application = PetApplication.where(pet_id: params[:pet_id]).where(application_id: params[:application_id]).first

    pet.toggle_adoptable
    pet_application.toggle_approved

    if !pet.adoptable
      redirect_to "/pets/#{params[:pet_id]}"
    else
      redirect_to "/applications/#{params[:application_id]}"
    end 
  end
end
