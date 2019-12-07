class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites_list.contents.keys
    @pets = pet_ids.map do |id|
      Pet.find(id.to_i)
    end
  end

  def create
    require "pry"; binding.pry
    selected_pets = params[:selected_pets]
    application = Application.new(application_params)
    #take this ! out at the end
    application.save!

    redirect_to '/favorites'
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip, :description)
    end

    # def selected_pets
    #   params.permit(:selected_pets)
    # end
end