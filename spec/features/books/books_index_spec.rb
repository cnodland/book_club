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
      review_2 = Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_2, user: user_1 )
      review_3 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_3, user: user_1 )
      review_4 = Review.create(title:"Bad review for book 4",review_text: "Loved it", rating: 5, book: book_4, user: user_1 )

      review_5 = Review.create(title:"Bad review for book 5",review_text: "hated", rating: 1, book: book_5, user: user_1 )
      review_6 = Review.create(title:"Bad review for book 6",review_text: "hated", rating: 1, book: book_6, user: user_1 )
      review_7 = Review.create(title:"Bad review for book 7",review_text: "hated", rating: 1, book: book_7, user: user_1 )
      review_8 = Review.create(title:"Bad review for book 8",review_text: "Loved it", rating: 2, book: book_8, user: user_1 )

      review_9 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_2 )
      review_10 = Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_2, user: user_2 )
      review_11= Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_3, user: user_2 )
      review_12 = Review.create(title:"Good review for book 4",review_text: "Loved it", rating:4 , book: book_4, user: user_2 )


      review_13 = Review.create(title:"Bad review for book 5",review_text: "hated it", rating: 1, book: book_5, user: user_2 )
      review_14 = Review.create(title:"Bad review for book 6",review_text: "hated it", rating: 1, book: book_6, user: user_2 )
      review_15 = Review.create(title:"Bad review for book 7",review_text: "hated it", rating: 1, book: book_7, user: user_2 )
      review_16 = Review.create(title:"Bad review for book 8",review_text: "hated it", rating: 2, book: book_8, user: user_2 )

      review_17 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_3 )
      review_18 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_3, user: user_3 )
      review_19 = Review.create(title:"Bad review for book 5",review_text: "hated it", rating: 1, book: book_5, user: user_3 )
      review_20 = Review.create(title:"Bad review for book 7",review_text: "hated it", rating: 1, book: book_7, user: user_3 )
      review_21 = Review.create(title:"Bad review for book 8",review_text: "hated it", rating: 2, book: book_8, user: user_3 )

      review_22= Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_2, user: user_4 )
      review_23 = Review.create(title:"Good review for book 4",review_text: "Loved it", rating: 4, book: book_4, user: user_4 )
      review_24 = Review.create(title:"Bad review for book 6",review_text: "hated it", rating: 1, book: book_6, user: user_4 )

      visit books_path
      # within '#statistics' do
      #   expect(page).to have_content("Books statistics")
      # end

        within '#top-3' do
          expect(page).to have_content("Best three books:")
          expect(page).to have_content(book_1.title)
          expect(page).to have_content(book_2.title)
          expect(page).to have_content(book_3.title)
        end
        within '#bottom-3' do
          expect(page).to have_content("Worst three books:")
          expect(page).to have_content(book_5.title)
          expect(page).to have_content(book_6.title)
          expect(page).to have_content(book_7.title)
        end
        within '#top-reviewers' do
          expect(page).to have_content("Top Reviewers:")
          expect(page).to have_content(user_1.username)
          expect(page).to have_content(user_2.username)
          expect(page).to have_content(user_3.username)
        end



    end

    it 'can sort books by average rating in ascending order' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )

      visit books_path
      click_button 'Sort by worst to best'

      expect(page.all('.book')[0]).to have_content("Good Book 3")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 1")

    end

    it 'can sort books by average rating in descending order' do
      coelho= Author.create(name:'Paulo Coelho')
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )

      visit books_path
      click_on 'Sort by best to worst'

      expect(page.all('.book')[0]).to have_content("Good Book 1")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 3")

    end

    it 'can sort books by number of pages ascending' do
      coelho= Author.create(name:'Paulo Coelho')
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 300, year: 2000)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 200, year: 2000)
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 100, year: 1988)
      visit books_path
      click_button "Sort by Pages Ascending"

      expect(page).to have_current_path(books_path(sort: "pages_asc"))
      expect(page.all('.book')[0]).to have_content("Good Book 1")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 3")
    end

    it 'can sort books by number of pages ascending' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 100, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 200, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 300, year: 2000)

      visit books_path
      click_button "Sort by Pages Descending"

      expect(page).to have_current_path(books_path(sort: "pages_desc"))
      expect(page.all('.book')[0]).to have_content("Good Book 3")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 1")
    end

    it 'can sort books by most reviewed to least' do
      coelho= Author.create(name:'Paulo Coelho')
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 147, year: 2000)
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )

      visit books_path
      click_button 'Sort by most reviewed'

      expect(page.all('.book')[0]).to have_content("Good Book 1")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 3")
    end

    it 'can sort books by least reviewed to most' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )

      visit books_path
      click_button 'Sort by least reviewed'

      expect(page.all('.book')[0]).to have_content("Good Book 3")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to have_content("Good Book 1")
    end

    it 'can return to index page with a button' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )
      visit books_path
      click_button 'Sort by least reviewed'
      click_button 'Take me home'

      expect(page.all('.book')[0]).to_not have_content("Good Book 3")
      expect(page.all('.book')[1]).to have_content("Good Book 2")
      expect(page.all('.book')[2]).to_not have_content("Good Book 1")
    end

    it 'can click on book titles and be taken to their show page' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)

      visit books_path

      click_on book_1.title
      expect(current_path).to eq(book_path(book_1))

      visit books_path

      click_on book_2.title
      expect(current_path).to eq(book_path(book_2))
    end

    it 'can click on any author and be taken to that author page' do
      coelho= Author.create(name:'Paulo Coelho')
      coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)

      visit books_path

      click_on coelho.name
      expect(current_path).to eq(author_path(coelho))
    end

    it 'can click on any user and be taken to that user show page' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book 1", page_count: 200, year: 1988)
      book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
      book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)

      user_1 = User.create(username:"User1")

      Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_2, user: user_1 )
      Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_3, user: user_1 )

      visit books_path
      click_on user_1.username

      expect(current_path).to eq(user_path(user_1))
    end
  end
end
