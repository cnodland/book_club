class BooksController < ApplicationController
  def index
    @books = Book.all
    @top_three_books = Book.sort_avg_rating(:desc)
    @worst_three_books = Book.sort_avg_rating(:asc)
    @top_three_reviewers = User.top_three_reviewers
  end
end
