require 'rails_helper'

RSpec.describe "book new page", type: :feature do
  it "allows user to create a new book" do
    visit new_book_path

    fill_in "book[title]", with: "Book Title"
    fill_in "book[page_count]", with: 133
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Author 1"
    click_button "Create Book"

    expect(page).to have_content("Book Title")
    expect(page).to have_content(133)
    expect(page).to have_content(2133)
    expect(page).to have_content("Author 1")
  end

  it 'allows user to create a new book with multiple authors' do
    visit new_book_path

    fill_in "book[title]", with: "Book title"
    fill_in "book[page_count]", with: 133
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Author 1, Author 2"
    click_button "Create Book"

    expect(page).to have_content("Author 1")
    expect(page).to have_content("Author 2")

  end

  it 'redirects to new form if fields are filled incorrectly' do
    visit new_book_path
    fill_in "book[title]", with: "Book title"
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Author 1"
    click_button "Create Book"

    expect(current_path).to eq(new_book_path)
  end

  it 'converts the book title to Title Case' do
    visit new_book_path
    fill_in "book[title]", with: "book title"
    fill_in "book[page_count]", with: 100
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Author 1"
    click_button "Create Book"

    expect(page).to have_content("Book Title")
  end

  it 'converts all author names to Title Case' do
    visit new_book_path
    save_and_open_page
    fill_in "book[title]", with: "book title"
    fill_in "book[page_count]", with: 100
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "author name"
    click_button "Create Book"


    expect(page).to have_content("Author Name")

  end

  it 'authors are unique in system' do
    author = Author.create(name: "Repeated Author")
    visit new_book_path
    fill_in "book[title]", with: "book title"
    fill_in "book[page_count]", with: 100
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Repeated Author"
    click_button "Create Book"
    # binding.pry

    expect(Author.where(name: "Repeated Author").count).to eq(1)

  end

  it 'book titles are unique in system' do
    author = Author.create(name: "Author")
    book = author.books.create!(title: "Repeated Title", page_count: 200, year: 100)

    visit new_book_path
    fill_in "book[title]", with: "Repeated Title"
    fill_in "book[page_count]", with: 200
    fill_in "book[year]", with: 100
    fill_in "book[authors]", with: "Repeated Author"
    click_button "Create Book"
    # binding.pry

    expect(Book.where(title: "Repeated Title").count).to eq(1)
  end

end
