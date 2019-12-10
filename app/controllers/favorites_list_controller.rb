class FavoritesListController < ApplicationController
  def index
    pet_ids = favorites_list.pet_ids
    @pets = Pet.where(id: pet_ids)

    @pets_with_applications = Pet.applied_for
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
    if params[:pet_id] == nil
      favorites_list.clear_all
    else
      pet = Pet.find(params[:pet_id])
      favorites_list.remove(params[:pet_id])
      flash[:notice] = "#{pet.name} has been removed from your Favorite Pets."
    end
    redirect_back(fallback_location: '/favorites')
  end
end
