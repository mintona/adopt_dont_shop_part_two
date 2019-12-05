class FavoritesListController < ApplicationController
  def index
    pet_ids = favorites_list.contents.keys
    @pets = pet_ids.map do |id|
      Pet.find(id.to_i)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites_list.add_pet(pet.id)
    session[:favorites_list] = favorites_list.contents
    quantity = favorites_list.count_of(pet.id)

    flash[:success] = "#{pet.name} has been added to your Favorite Pets!"

    redirect_to "/pets/#{params[:pet_id]}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites_list.contents.delete(params[:pet_id])
    flash[:notice] = "#{pet.name} has been removed from your Favorite Pets."
    redirect_to "/pets/#{params[:pet_id]}"
  end

end
