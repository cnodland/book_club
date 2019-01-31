require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :username}
  end

  describe 'Class Methods' do
    describe '.top_three_reviewers' do
      it 'returns the three users with most reviews' do
        coelho= Author.create(name:'Paulo Coelho')
        book_1 = coelho.books.create(title:"Good Book", page_count: 200, year: 1988)

        user_1 = User.create(username:"User1")
        user_2 = User.create(username:"User2")
        user_3 = User.create(username:"User3")
        user_4 = User.create(username:"User4")


        Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
        Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_1, user: user_1 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_1 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_3 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_3 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_4 )

        expected = [user_1, user_2, user_3]

        expect(User.top_three_reviewers).to eq(expected)

      end

      it 'only returns three users even if two users have the same amount of reviews' do
        coelho= Author.create(name:'Paulo Coelho')
        book_1 = coelho.books.create(title:"Good Book", page_count: 200, year: 1988)

        user_1 = User.create(username:"User1")
        user_2 = User.create(username:"User2")
        user_3 = User.create(username:"User3")
        user_4 = User.create(username:"User4")


        review_1 = Review.create!(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
        review_2 = Review.create!(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_1, user: user_1 )
        review_3 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_1 )
        review_4 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_1)
        review_5 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        review_6 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        review_7 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_2 )
        review_8 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_3 )
        review_9 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_3 )
        review_10 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_4 )
        review_11 = Review.create!(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_4 )

        actual = User.top_three_reviewers
        
        expect(actual.length).to eq(3)
      end
    end
  end
end
