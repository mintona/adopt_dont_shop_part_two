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
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def update_adoptable
    pet = Pet.find(params[:id])
    if pet.adoptable
      pet.update(adoptable: false)
    else
      pet.update(adoptable: true)
    end
    redirect_to "/pets/#{pet.id}"
  end

  private
    def pet_params
      params.permit(:image, :name, :description, :approximate_age, :sex)
    end

end
