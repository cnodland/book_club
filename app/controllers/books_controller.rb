class BooksController < ApplicationController
  def index
    @top_three_books = Book.sort_avg_rating(:desc, 3)
    @worst_three_books = Book.sort_avg_rating(:asc, 3)
    @top_three_reviewers = User.top_three_reviewers
    @books = get_books(params)
  end

  def show
    @book = Book.find(params[:id])
    @top_three_reviews = @book.sort_three_reviews(:desc)
    @bottom_three_reviews = @book.sort_three_reviews(:asc)
    @avg_rating = @book.average_rating

  end

  def new
    @authors = Author.new
    @book = Book.new
  end

  def create
    @book = Book.find_or_initialize_by(book_params)
   all_authors = params[:book][:authors]
   array_authors = all_authors.split(',')
   array_authors.each do |author|
     @book.authors << Author.find_or_create_by(name: author.titleize)
   end

   @book.title = @book.title.titleize

   if @book.save
     redirect_to book_path(@book)
   else
     redirect_to new_book_path
   end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    # binding.pry
    params.require(:book).permit(:title, :page_count, :year, :authors => [])
  end

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
