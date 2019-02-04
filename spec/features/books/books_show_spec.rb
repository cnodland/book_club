require 'rails_helper'

RSpec.describe 'as a visitor', type: :feature do
  describe 'when I visit a books show page' do
    before :each do
      @author = Author.create(name: 'Trevor')
      @author2 = Author.create(name: 'Teresa')
      @book1 = Book.create(title: 'book1', page_count: 200, year: 2019, authors: [@author, @author2])
      @book2 = Book.create(title: 'book2', page_count: 100, year: 2018, authors: [@author])
      @user1 = User.create(username: 'user1')
      @user2 = User.create(username: 'user2')
      @user3 = User.create(username: 'user3')
      @review1 = Review.create(title: 'review 1', review_text: 'was not worth the read', rating: 1, book: @book1, user: @user1)
      @review2 = Review.create(title: 'review 2', review_text: 'was not worth the read', rating: 2, book: @book1, user: @user1)
      @review3 = Review.create(title: 'review 3', review_text: 'was worth the read', rating: 5, book: @book1, user: @user2)
      @review4 = Review.create(title: 'review 4', review_text: 'was worth the read', rating: 5, book: @book2, user: @user3)

    end

    it 'should show the books title author(s) and pages' do
      visit book_path(@book1)

      expect(page).to have_content(@book1.title)
      expect(page).to have_content(@book1.page_count)
      expect(page).to have_content(@author.name)
      expect(page).to have_content(@author2.name)
    end

    it 'should show a list of reviews for the book' do
      visit book_path(@book1)

      within '#reviews' do
        expect(page).to have_content(@user1.username)
        expect(page).to have_content(@review1.title)
        expect(page).to have_content(@review1.rating)
        expect(page).to have_content(@review1.review_text)
        expect(page).to have_content(@user2.username)
        expect(page).to have_content(@review2.title)
        expect(page).to have_content(@review2.rating)
        expect(page).to have_content(@review2.review_text)
      end
    end

    it 'should shows statistics about the book' do
      visit book_path(@book1)

      within '#top_three' do
        top_3 = page.all('p')

        top_3[0].has_content?("Review: #{@review4.title}")
        top_3[0].has_content?("Rating: #{@review4.rating}")
        top_3[0].has_content?("User: #{@review4.user.username}")

        top_3[1].has_content?("Review: #{@review3.title}")
        top_3[1].has_content?("Rating: #{@review3.rating}")
        top_3[1].has_content?("User: #{@review3.user.username}")

        top_3[2].has_content?("Review: #{@review2.title}")
        top_3[2].has_content?("Rating: #{@review2.rating}")
        top_3[2].has_content?("User: #{@review2.user.username}")


      end

      within '#bottom_three' do
        bottom_3 = page.all('p')

        bottom_3[0].has_content?("Review: #{@review1.title}")
        bottom_3[0].has_content?("Rating: #{@review1.rating}")
        bottom_3[0].has_content?("User: #{@review1.user.username}")

        bottom_3[1].has_content?("Review: #{@review2.title}")
        bottom_3[1].has_content?("Rating: #{@review2.rating}")
        bottom_3[1].has_content?("User: #{@review2.user.username}")

        bottom_3[2].has_content?("Review: #{@review3.title}")
        bottom_3[2].has_content?("Rating: #{@review3.rating}")
        bottom_3[2].has_content?("User: #{@review3.user.username}")
      end
      within '#avg_rating' do
        expect(page).to have_content('Average Rating: 2.67')
      end
    end

    it 'should link the author name to their show page' do
      visit book_path(@book1)

      click_on @author.name

      expect(current_path).to eq(author_path(@author))
    end

    it 'should link an username to that user show page' do
      visit book_path(@book2)


      within '#reviews' do
        click_on @user3.username
        expect(current_path).to eq(user_path(@user3))
      end
    end
  end
end
