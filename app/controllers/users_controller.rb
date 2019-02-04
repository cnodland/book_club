class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = get_reviews(params)
  end


  private
  def get_reviews(params)
    if params[:sort] == 'reviews_newest'
      @reviews = @user.reviews.order("created_at desc")
    elsif params[:sort] == 'reviews_oldest'
      @reviews = @user.reviews.order('created_at asc')
    else
      @reviews = @user.reviews
    end

  end
end
