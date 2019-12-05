class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites_list

  def favorites_list
    @favorites_list ||= FavoritesList.new(session[:favorites_list])
  end
end
