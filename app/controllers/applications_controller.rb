class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites_list.pet_ids
    @pets = Pet.where(id: pet_ids)
  end

  def create
    application = Application.new(application_params)

    if params[:selected_pets] == nil
      flash[:notice] = "Please select at least one pet."
      pet_ids = favorites_list.pet_ids
      @pets = Pet.where(id: pet_ids)
      render :new

    elsif application.save
      selected_pet_ids = params[:selected_pets]
      @selected_pets = Pet.where(id: selected_pet_ids)

      @selected_pets.each do |pet|
        pet.applications << application
      end
      # next method can be refactored somehow I'm sure in favorites_list PORO
      selected_pet_ids.each do |id|
        favorites_list.remove(id)
      end

      flash[:success] = "You have applied to adopt your selected pets."
      redirect_to '/favorites'

    else
      flash[:notice] = "Please fill out all fields."
      pet_ids = favorites_list.pet_ids
      @pets = Pet.where(id: pet_ids)
      render :new
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone, :description)
    end
end
