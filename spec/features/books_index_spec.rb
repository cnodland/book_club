require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I go to books/index' do
    it 'can see all books' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"The Monk", page_count: 150, year: 2000)

      visit '/books'

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
    end
  end
end
