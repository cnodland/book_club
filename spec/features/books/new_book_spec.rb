require 'rails_helper'

RSpec.describe "book new page", type: :feature do
  it "allows user to create a new book" do
    visit new_book_path

    fill_in "book[title]", with: "Book title"
    fill_in "book[page_count]", with: 133
    fill_in "book[year]", with: 2133
    fill_in "book[authors]", with: "Author 1"
    click_button "Create Book"
    # save_and_open_page

    expect(page).to have_content("Book title")
    expect(page).to have_content(133)
    expect(page).to have_content(2133)
    expect(page).to have_content("Author 1")
  end
end
