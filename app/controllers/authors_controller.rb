class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def destroy
    # binding.pry
    @author = Author.find(params[:id])
    # AuthorBook.where(author_id: @author.id).destroy_all
    @author.books.each do |book|
      book.destroy
    end
    @author.destroy
    redirect_to books_path
  end
end
