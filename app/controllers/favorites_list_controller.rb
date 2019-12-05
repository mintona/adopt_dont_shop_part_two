class FavoritesListController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    @favorites_list = FavoritesList.new(session[:favorites_list])
    @favorites_list.add_pet(pet.id)
    session[:favorites_list] = @favorites_list.contents
    quantity = @favorites_list.count_of(pet.id)

    flash[:success] = "#{pet.name} has been added to your Favorite Pets!"

    redirect_to "/pets/#{params[:pet_id]}"
  end
end
