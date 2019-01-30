require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  #add before
  # before :each do
  describe 'When I go to books/index' do
    it 'can see all books' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"The Monk", page_count: 150, year: 2000)

      visit books_path

      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_2.title)
    end

    it 'should show author(s), page count and publishing year for each book' do
      coelho = Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"The Monk", page_count: 150, year: 2000)

      martin = Author.create(name:'George R.R. Martin')
      book_3 = martin.books.create(title:'A Game of Thrones', page_count: 333, year: 1997)
      book_4 = Book.create(title: "Book 4", page_count: 178, year: 2010, authors: [martin, coelho])

      visit books_path

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

      visit books_path

      within "#title-#{book_1.id}"do
        expect(page).to have_content ("Rating: 3")
        expect(page).to have_content ("Number of reviews: 2")
      end

    end

    it 'shows statistics about all books' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)
      book_4 = coelho.books.create(title:"Decent Book", page_count: 150, year: 2000)

      martin = Author.create(name:"Martin")
      book_5 = martin.books.create(title:"Bad Book", page_count: 1000, year: 2017)
      book_6 = martin.books.create(title:"Pretty bad Book", page_count: 1000, year: 2017)
      book_7 = martin.books.create(title:"Pretty bad book 3", page_count: 1000, year: 2017)
      book_8 = martin.books.create(title:"Okayish book", page_count: 1000, year: 2017)

      user_1 = User.create(username:"User1")
      user_2 = User.create(username:"User2")
      user_3 = User.create(username:"User3")
      user_4 = User.create(username:"User4")

      review_1 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_2 = Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_3 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_4 = Review.create(title:"Bad review for book 4",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )

      review_5 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_6 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_7 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review_8 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )


    end


  end
end
