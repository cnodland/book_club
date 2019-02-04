require 'rails_helper'

RSpec.describe 'When I visit the new review page' do
  it 'should add a new review' do
    author = Author.create(name: "Author")
    book = author.books.create(title: "Test book", page_count: 200, year: 2010)
    visit new_book_review_path(book)

    fill_in "review[title]", with: "Review title"
    fill_in "review[user]", with: "Username"
    fill_in "review[review_text]", with: "Review text goes here lalalalalalalalallalalalalaallaalallalala"
    fill_in "review[rating]", with: 5
    click_button "Create Review"

    expect(current_path).to eq(book_path(book))

    expect(page).to have_content("Review title")
    expect(page).to have_content("Username")
    expect(page).to have_content(5)
    expect(page).to have_content("Review text goes here lalalalalalalalallalalalalaallaalallalala")

  end

  it 'can only rate a book from 1 to 5' do
    author = Author.create(name: "Author")
    book = author.books.create(title: "Test book", page_count: 200, year: 2010)
    visit new_book_review_path(book)

    fill_in "review[title]", with: "Review title"
    fill_in "review[user]", with: "Username"
    fill_in "review[review_text]", with: "Review text goes here lalalalalalalalallalalalalaallaalallalala"
    fill_in "review[rating]", with: 10
    click_button "Create Review"

    expect(current_path).to eq(new_book_review_path(book))
  end

  it 'should convert user names to Title Case' do
    author = Author.create(name: "Author")
    book = author.books.create(title: "Test book", page_count: 200, year: 2010)
    visit new_book_review_path(book)

    fill_in "review[title]", with: "Review title"
    fill_in "review[user]", with: "user name"
    fill_in "review[review_text]", with: "Review text goes here lalalalalalalalallalalalalaallaalallalala"
    fill_in "review[rating]", with: 5
    click_button "Create Review"

    expect(page).to have_content("User Name")
  end

  it 'should have unique users in the system' do
    author = Author.create(name: "Author")
    book = author.books.create(title: "Test book", page_count: 200, year: 2010)
    user = User.create(username: "Username")
    visit new_book_review_path(book)

    fill_in "review[title]", with: "Review title"
    fill_in "review[user]", with: "Username"
    fill_in "review[review_text]", with: "Review text goes here lalalalalalalalallalalalalaallaalallalala"
    fill_in "review[rating]", with: 5
    click_button "Create Review"

    expect(User.where(username: user.username).count).to eq(1)
  end

end
