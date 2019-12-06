class ApplicationsController < ApplicationController
  def new
    pet_ids = favorites_list.contents.keys
    @pets = pet_ids.map do |id|
      Pet.find(id.to_i)
    end
  end
end