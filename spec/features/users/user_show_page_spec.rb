require 'rails_helper'

RSpec.describe 'When I visit a user show page' do
  it 'should show all reviews by that user' do
    author = Author.create(name:"Test author")
    user = User.create(username:"Test user")
    unwanted_user = User.create(username: "Should not appear")

    book_1 = author.books.create(title:"Book1", page_count: 200, year: 2013)
    book_2 = author.books.create(title:"Book2", page_count: 200, year: 2013)
    book_3 = author.books.create(title:"Book3", page_count: 200, year: 2013)
    book_4 = author.books.create(title:"Book4", page_count: 200, year: 2013)
    book_5 = author.books.create(title:"Book5", page_count: 200, year: 2013)

    review_1 = Review.create(title: "Review title", rating: 5, review_text: "Review text for review 1", book: book_1, user: user)
    review_2 = Review.create(title: "Review title", rating: 4, review_text: "Review text for review 2", book: book_2, user: user)
    review_3 = Review.create(title: "Review title", rating: 3, review_text: "Review text for review 2", book: book_3, user: user)
    review_4 = Review.create(title: "Review title", rating: 2, review_text: "Review text for review 2", book: book_4, user: user)
    review_5 = Review.create(title: "Review title", rating: 1, review_text: "Review text for review 2", book: book_5, user: user)
    review_6 = Review.create(title: "Review title for review from different user", rating: 1, review_text: "Review text for review 6", book: book_1, user: unwanted_user)

    visit user_path(user)

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_3.title)
    expect(page).to have_content(review_4.title)
    expect(page).to have_content(review_5.title)
    expect(page).to_not have_content(review_6.title)
  end
end
