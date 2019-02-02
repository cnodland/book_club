require 'rails_helper'

RSpec.describe "When I visit an author's show page", type: :feature do

  before :each do
    @author_1 = Author.create(name:"Author 1")
    @author_2 = Author.create(name:"Author 2")

    @book_1 = @author_1.books.create(title:"Author 1 book", page_count: 100, year: 2010)
    @book_2 = @author_2.books.create(title:"Author 2 book", page_count: 150, year: 2011)
    @book_3 = Book.create(title:"Co authored", page_count: 150, year: 2011, authors: [@author_2, @author_1])

  end
  xit 'should show a list of all books and any co-authors' do

    visit author_path(@author_1)
    save_and_open_page

    expect(page).to_not have_content(@book_2.title)

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_1.page_count)
    expect(page).to have_content(@book_1.year)

    expect(page).to have_content(@book_3.title)
    expect(page).to have_content(@book_3.page_count)
    expect(page).to have_content(@book_3.year)

    expect(page).to have_content(@author_2.name)

  end
end
