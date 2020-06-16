class ReviewsController < ApplicationController

# check if logged in (but we don't want to do this on index or show)
before_action :check_login, except: [:index, :show]

def index
  # this is our list page for reviews

# from the URL ... params
  @price = params[:price]
  @cuisine = params[:cuisine]
  @location = params[:location]

# start with all reviews
@reviews = Review.all

# filter by price
if @price.present?
  @reviews = @reviews.where(price: @price)
end

# filter by Cuisine
if @cuisine.present?
  @reviews = @reviews.where(cuisine: @cuisine)
end

# search near location
if @location.present?
  @reviews = @reviews.near(@location)
end


end


def new
  # this is the form for adding a new review
@review = Review.new
  end

def create
# take info from the form and add it to the model
  @review = Review.new(form_params)

  # associate it with a user
  @review.user = @current_user

# we want to check if the model can be saved
# if it can, we go to the homepage again
# if it can't, we show the new form
  if @review.save
    redirect_to root_path

     # show the view for new.html.erb
  else
    render "new"
end

end


def show
  # individual review page
  @review = Review.find(params[:id])
  end

  def destroy

    # find the individual review
    @review = Review.find(params[:id])

    # destroy if they have access
    if @review.user == @current_user
    @review.destroy
  end

    # redirect to homepage
    redirect_to root_path
  end

def edit
  # find the individual review (to edit)
  @review = Review.find(params[:id])

  if @review.user != @current_user
    redirect_to root_path
  elsif @review.created_at < 1.hour.ago
    redirect_to review_path(@review)

  end
end

def update
  # find the individual review
  @review = Review.find(params[:id])

  if @review.user != @current_user
    redirect_to root_path
  else

    # update with the new info from the form
  if @review.update(form_params)

      # redirect somewhere new
      redirect_to review_path(@review)

      flash[:success] = "Your review was successfully updated!"
    else
    render "edit"
    end
  end
end

  def form_params
    params.require(:review).permit(:title, :restaurant, :cuisine, :price, :body, :score, :ambiance, :phone_number, :address, :photo)
  end

end
