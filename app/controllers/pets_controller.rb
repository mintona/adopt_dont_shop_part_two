class PetsController < ApplicationController

  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    pet = Pet.new(pet_params)
    pet.shelter_id = params[:shelter_id]
    pet.save!
    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      flash[:success] = "The information for #{pet.name} has been updated."
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:notice] = pet.errors.full_messages.to_sentence + ". Please fill out all required fields."
      @pet = Pet.find(params[:id])
      render :edit
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.approved_application?
      flash[:notice] = "#{pet.name} has an approved application and cannot be deleted."
      @pet = Pet.find(params[:id])
      render :show
    else
      Pet.destroy(params[:id])
      favorites_list.remove(params[:id])
      redirect_to '/pets'
    end
  end

  private
    def pet_params
      params.permit(:image, :name, :description, :approximate_age, :sex)
    end

end
