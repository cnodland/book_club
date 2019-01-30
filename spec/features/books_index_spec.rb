require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I go to books/index' do
    xit 'can see all books' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"The Monk", page_count: 150, year: 2000)

      visit '/books'

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
    end

    xit 'should show author(s), page count and publishing year for each book' do
      coelho = Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"The Monk", page_count: 150, year: 2000)

      martin = Author.create(name:'George R.R. Martin')
      book_3 = martin.books.create(title:'A Game of Thrones', page_count: 333, year: 1997)
      book_4 = Book.create(title: "Book 4", page_count: 178, year: 2010, authors: [martin, coelho])

      visit '/books'


      within "#book-#{book_1.id}" do
        expect(page).to have_content (book_1.title)
        expect(page).to have_content (book_1.page_count)
        expect(page).to have_content (book_1.year)
        expect(page).to have_content (book_1.authors.first.name)
        expect(page).to_not have_content (book_2.title)
      end

      within "#book-#{book_2.id}" do
        expect(page).to have_content (book_2.title)
        expect(page).to have_content (book_2.page_count)
        expect(page).to have_content (book_2.year)
        expect(page).to have_content (book_2.authors.first.name)
      end

      within "#book-#{book_3.id}" do
        expect(page).to have_content (book_3.title)
        expect(page).to have_content (book_3.page_count)
        expect(page).to have_content (book_3.year)
        expect(page).to have_content (book_3.authors.first.name)
      end

      within "#book-#{book_4.id}" do
        expect(page).to have_content (book_4.title)
        expect(page).to have_content (book_4.page_count)
        expect(page).to have_content (book_4.year)
        expect(page).to have_content (book_4.authors.first.name)
        expect(page).to have_content (book_4.authors.last.name)
      end
    end

    it 'shows the average rating and total ratings next to title' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      user = User.create(username: "User")
      good_review = Review.create(rating: 5, title: "loved it", review_text: "great book!", user_id: user.id, book_id: book_1.id)
      bad_review = Review.create(rating: 1, title: "hated it", review_text: "terrible book!", user_id: user.id, book_id: book_1.id)

      visit '/books'

      within "#title-#{book_1.id}"do
        expect(page).to have_content ("Rating: 3")
        expect(page).to have_content ("Number of reviews: 2")
      end

    end
  end
end
