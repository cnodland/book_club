require 'rails_helper'

RSpec.describe 'as a visitor', type: :feature do
  describe 'when I visit a books show page' do
    it 'should show the books title author(s) and pages' do
      author = Author.create(name: 'Trevor')
      author2 = Author.create(name: 'Teresa')
      book1 = Book.create(title: 'book1', page_count: 200, year: 2019, authors: [author, author2])
      user1 = User.create(username: 'cooldude1000')
      review1 = Review.create(title: 'books sucked', review_text: 'was not worth the read', rating: 1, book: book1, user: user1)

      visit book_path(book1)

      expect(page).to have_content(book1.title)
      expect(page).to have_content(book1.page_count)
      expect(page).to have_content(author.name)
      expect(page).to have_content(author2.name)
    end
    it 'should show a list of reviews for the book' do

    end
  end
end
