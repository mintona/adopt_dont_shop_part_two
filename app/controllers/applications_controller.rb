class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites_list.contents.keys
    @pets = pet_ids.map do |id|
      Pet.find(id.to_i)
    end
  end

  def create
    application = Application.create!(application_params)

    selected_pet_ids = params[:selected_pets]

    @selected_pets = selected_pet_ids.map do |id|
      Pet.find(id.to_i)
    end

    @selected_pets.each do |pet|
      pet.applications << application
    end

    selected_pet_ids.each do |id|
      favorites_list.remove(id)
    end

    flash[:success] = "You have applied to adopt your selected pets."

    redirect_to '/favorites'
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :description)
    end
end