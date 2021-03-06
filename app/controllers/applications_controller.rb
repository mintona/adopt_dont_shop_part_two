class ApplicationsController < ApplicationController
  def index
    @applications = Application.find_applications(params[:pet_id])
  end

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

      remove_from_favorites(@selected_pets)

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

    def remove_from_favorites(pets)
      application = Application.new(application_params)

      pets.each do |pet|
        favorites_list.remove(pet.id)
        pet.applications << application
      end
    end
end
