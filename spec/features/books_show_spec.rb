require 'rails_helper'

RSpec.describe 'as a visitor', type: :feature do
  describe 'when I visit a books show page' do
    before :each do
      @author = Author.create(name: 'Trevor')
      @author2 = Author.create(name: 'Teresa')
      @book1 = Book.create(title: 'book1', page_count: 200, year: 2019, authors: [@author, @author2])
      @user1 = User.create(username: 'cooldude1000')
      @user2 = User.create(username: 'cooldude1001')
      @review1 = Review.create(title: 'book sucked', review_text: 'was not worth the read', rating: 1, book: @book1, user: @user1)
      @review2 = Review.create(title: 'book sucked', review_text: 'was not worth the read', rating: 2, book: @book1, user: @user1)
      @review3 = Review.create(title: 'book rocked', review_text: 'was worth the read', rating: 4, book: @book1, user: @user2)
      @review4 = Review.create(title: 'book rocked', review_text: 'was worth the read', rating: 5, book: @book1, user: @user2)
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
        expect(page.find('p:nth-child(1)')).to have_content(@review4.title)
        expect(page.find('p:nth-child(2)')).to have_content(@review3.title)
        expect(page.find('p:nth-child(3)')).to have_content(@review2.title)

        expect(page.find('p:nth-child(1)')).to have_content(@review4.user.username)
        expect(page.find('p:nth-child(2)')).to have_content(@review3.user.username)
        expect(page.find('p:nth-child(3)')).to have_content(@review2.user.username)

        expect(page.find('p:nth-child(1)')).to have_content(@review4.rating)
        expect(page.find('p:nth-child(2)')).to have_content(@review3.rating)
        expect(page.find('p:nth-child(3)')).to have_content(@review2.rating)

      end

      within '#bottom_three' do
        expect(page.find('p:nth-child(1)')).to have_content(@review1.title)
        expect(page.find('p:nth-child(2)')).to have_content(@review2.title)
        expect(page.find('p:nth-child(3)')).to have_content(@review3.title)

        expect(page.find('p:nth-child(1)')).to have_content(@review1.user.username)
        expect(page.find('p:nth-child(2)')).to have_content(@review2.user.username)
        expect(page.find('p:nth-child(3)')).to have_content(@review3.user.username)

        expect(page.find('p:nth-child(1)')).to have_content(@review1.rating)
        expect(page.find('p:nth-child(2)')).to have_content(@review2.rating)
        expect(page.find('p:nth-child(3)')).to have_content(@review3.rating)

      end

      within '#avg_rating' do

      end
    end
  end
end
