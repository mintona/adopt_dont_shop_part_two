class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    require "pry"; binding.pry
    review.shelter_id = params[:shelter_id]

    review.save!
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :image)
    end
end
