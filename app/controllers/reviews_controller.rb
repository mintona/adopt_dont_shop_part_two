class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    review.shelter_id = params[:shelter_id]

    if review.save
      flash[:success] = 'Your review has been posted.'
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please fill out all required fields."
      @shelter_id = params[:shelter_id]
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  def destroy
    Review.destroy(params[:review_id])
    
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
