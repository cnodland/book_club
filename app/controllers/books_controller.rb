class BooksController < ApplicationController
  def index

    if params[:sort_by_worst_to_best => true]

      @books = Book.sort_avg_rating("asc")
    else
      @books = Book.all 
      @top_three_books = Book.sort_avg_rating(:desc)
      @worst_three_books = Book.sort_avg_rating(:asc)
      @top_three_reviewers = User.top_three_reviewers
    end

  end
end
