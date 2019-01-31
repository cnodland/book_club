class BooksController < ApplicationController
  def index
    @top_three_books = Book.sort_avg_rating(:desc, 3)
    @worst_three_books = Book.sort_avg_rating(:asc, 3)
    @top_three_reviewers = User.top_three_reviewers
    @books = get_books(params)
  end

  private

  def get_books(params)
    if params[:sort] == "pages_asc"
      @books = Book.order(:page_count)
    elsif params[:sort] == "pages_desc"
      @books = Book.order(page_count: :desc)
    elsif params[:sort] == "avg_rating_asc"
      @books = Book.sort_avg_rating("asc")
    elsif params[:sort] == "avg_rating_desc"
      @books = Book.sort_avg_rating("desc")
    elsif params[:sort] == "num_reviews_desc"
      @books = Book.sort_num_reviews("desc")
    elsif params[:sort] == "num_reviews_asc"
      @books = Book.sort_num_reviews("asc")
    else
      @books = Book.all
    end

  end
end
