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
    describe '.average_rating'
    it 'should get average rating across several reviews' do
      coelho= Author.create(name:'Paulo Coelho')
      user = User.create(username: "User")

      book_1 = coelho.books.create(title:"The Alchemist", page_count: 200, year: 1988)
      book_1.reviews.create(title: "loved it", review_text: "Great book", rating: 5, user: user)
      book_1.reviews.create(title: "meh", review_text: "Great book", rating: 2, user: user)
      book_1.reviews.create(title: "loved it", review_text: "Great book", rating: 4, user: user)

      expect(book_1.average_rating).to eq(3.67)
    end
  end
end
