class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @user = User.find_or_create_by(username: review_params[:user].titleize)
    @review = Review.new(title: review_params[:title], review_text: review_params[:review_text], rating: review_params[:rating], user: @user, book: @book)
    if @review.save
      redirect_to book_path(@book)
    else
      redirect_to new_book_review_path(@book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :user, :review_text, :rating)

  end
end
