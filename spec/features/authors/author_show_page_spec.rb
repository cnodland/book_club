require 'rails_helper'

RSpec.describe "When I visit an author's show page", type: :feature do

  before :each do
    @author_1 = Author.create(name:"Author 1")
    @author_2 = Author.create(name:"Author 2")

    @book_1 = @author_1.books.create(title:"Author 1 book", page_count: 100, year: 2010)
    @book_2 = @author_2.books.create(title:"Author 2 book", page_count: 150, year: 2011)
    @book_3 = Book.create(title:"Co authored", page_count: 150, year: 2011, authors: [@author_2, @author_1])

    @user_1 = User.create(username: "User 1")
    @user_2 = User.create(username: "User 2")
    @review_1 = Review.create(title: "Good review", review_text: "review text great book", rating: 5, user: @user_1, book: @book_1)
    @review_2 = Review.create(title: "ok review", review_text: "ok", rating: 3, user: @user_1, book: @book_1)
    @review_3 = Review.create(title: "bad review", review_text: "bad", rating: 2, user: @user_1, book: @book_1)
    @review_4 = Review.create(title: "terrible review", review_text: "terrible", rating: 1, user: @user_1, book: @book_3)
    @review_5 = Review.create(title:"Good review from user 2", review_text: "review text", rating: 5, user: @user_2, book: @book_3)
  end
  it 'should show a list of all books and any co-authors' do

    visit author_path(@author_1)

    expect(page).to_not have_content(@book_2.title)

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content(@book_1.page_count)
    expect(page).to have_content(@book_1.year)

    expect(page).to have_content(@book_3.title)
    expect(page).to have_content(@book_3.page_count)
    expect(page).to have_content(@book_3.year)

    expect(page).to have_content(@author_2.name)

  end

  it 'should show a top review from each book' do
    visit author_path(@author_1)

    expect(page).to have_content(@review_1.title)
    expect(page).to_not have_content(@review_2.title)
    expect(page).to_not have_content(@review_3.title)

  end

  it 'should go to a user show page when clicked on username' do
    visit author_path(@author_1)

    click_on @user_2.username


    expect(current_path).to eq(user_path(@user_2))
  end

  it 'should be able to delete an author' do
    visit author_path(@author_2)

    click_button 'Delete this author'
    # save_and_open_page

    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(@book_2.title)
    expect(page).to have_content(@book_1.title)

    expect(page).to_not have_content(@book_3.title)
    expect(page).to_not have_content(@author_2.name)
    expect(page).to have_content(@author_1.name)
  end

end
