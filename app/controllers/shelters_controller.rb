class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
      flash[:success] = "The shelter has been created!"
    else
      flash.now[:notice] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
      flash[:success] = "The shelter has been updated!"
    else
      flash.now[:notice] = shelter.errors.full_messages.to_sentence
      @shelter = Shelter.find(params[:id])
      render :edit
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  private
    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
