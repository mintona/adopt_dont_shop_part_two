class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    review.shelter_id = params[:shelter_id]

    if review.save
      if params[:image] == ""
        review.update!(image: default_image)
      end
      flash[:success] = 'Your review has been posted.'
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please fill out all required fields."
      @shelter_id = params[:shelter_id]
      render :new
    end
  end

  def edit
    @shelter_id = params[:shelter_id]
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      flash[:success] = 'Your review has been updated.'
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please fill out all required fields."
      @shelter_id = params[:shelter_id]
      render :edit
    end
  end

  def destroy
    Review.destroy(params[:review_id])

    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def default_image
    "https://graphicriver.img.customer.envatousercontent.com/files/246499059/CartoonDogHouse%20p.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=9f00414c5801c1dc1187e46311a2a1dc"
  end
end
