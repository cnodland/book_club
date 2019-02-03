require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :author_books}
    it {should have_many(:authors).through(:author_books)}
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :year}
  end


  describe 'Instance Methods' do
    it 'should get average rating across several reviews' do
      coelho= Author.create(name:'Paulo Coelho')
      user = User.create(username: "User")

      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_1.reviews.create(title: "loved it", review_text: "Great book", rating: 5, user: user)
      book_1.reviews.create(title: "meh", review_text: "Great book", rating: 2, user: user)
      book_1.reviews.create(title: "loved it", review_text: "Great book", rating: 4, user: user)

      expect(book_1.average_rating).to eq(3.67)
    end

    it 'can sort by best and worst reviews' do
      coelho= Author.create(name:'Paulo Coelho')
      book_1 = coelho.books.create(title:"Good Book", page_count: 200, year: 1988)

      user_1 = User.create(username:"User1")
      user_2 = User.create(username:"User2")
      user_3 = User.create(username:"User3")
      user_4 = User.create(username:"User4")

      review1 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
      review2 = Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_1, user: user_2 )
      review3 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_1, user: user_3 )
      review4 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_1, user: user_4 )

      worst_reviews = [review4, review3, review2]
      best_reviews = [review1, review2, review3]

      expect(book_1.sort_three_reviews(:asc)).to eq(worst_reviews)
      expect(book_1.sort_three_reviews(:desc)).to eq(best_reviews)
    end

    it 'can return any co authors' do
      author_1 = Author.create(name:"Author 1")
      author_2 = Author.create(name:"Author 2")
      author_3 = Author.create(name: "Author 3")

      author_1.books.create(title:"Author 1 book", page_count: 100, year: 2010)
      author_2.books.create(title:"Author 2 book", page_count: 150, year: 2011)
      book_3 = Book.create(title:"Co authored", page_count: 150, year: 2011, authors: [author_2, author_1])
      author_3.books.create(title:"Should not appear here", page_count: 20, year: 3000)


      expect(book_3.co_authors(author_1)).to eq([author_2])
    end
  end

  describe 'Class Methods' do
    describe '.sort_avg_rating' do
      it 'can sort the books by average rating' do
        coelho= Author.create(name:'Paulo Coelho')
        book_1 = coelho.books.create(title:"Good Book", page_count: 200, year: 1988)
        book_2 = coelho.books.create(title:"Good Book 2", page_count: 150, year: 2000)
        book_3 = coelho.books.create(title:"Good Book 3", page_count: 150, year: 2000)
        book_4 = coelho.books.create(title:"Decent Book", page_count: 150, year: 2000)

        user_1 = User.create(username:"User1")

        Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
        Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_2, user: user_1 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 3, book: book_3, user: user_1 )
        Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 1, book: book_4, user: user_1 )


        worst_books = [book_4, book_3, book_2]
        best_books = [book_1, book_2, book_3]

        expect(Book.sort_avg_rating("asc", 3)).to eq(worst_books)
        expect(Book.sort_avg_rating("desc", 3)).to eq(best_books)

      end


    end
  end
end
