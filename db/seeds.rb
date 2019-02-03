AuthorBook.destroy_all
Book.destroy_all
Author.destroy_all

martin = Author.create(name: "George R.R. Martin")
book_1 = martin.books.create(title: "A Game of Thrones", page_count: 694, year: 1996)
book_2 = martin.books.create(title: "A Clash of Kings", page_count: 761, year: 1998)
book_3 = martin.books.create(title: "A Storm of Swords", page_count: 973, year: 2000)

tolkien = Author.create(name: "J.R.R. Tolkien")
book_4 = tolkien.books.create(title: "The Hobbit", page_count: 310, year: 1937)
book_5 = tolkien.books.create(title:"The Silmarillion", page_count: 365, year: 1977)

franzen = Author.create(name:"Jonathan Franzen")
gladwell = Author.create(name:"Malcolm Gladwell")

book_6 = franzen.books.create(title:"The Corrections", page_count: 568 , year: 2001)
book_7 = franzen.books.create(title:"Purity", page_count: 563, year: 2015)

book_8 = gladwell.books.create(title:"The Tipping Point", page_count: 304 , year:2000)
book_9 = gladwell.books.create(title:"Outliers", page_count: 304 , year: 2008)

rothfuss = Author.create(name:"Patrick Rothfuss")

book_10 = rothfuss.books.create(title:"The Name of the Wind", page_count: 662, year: 2007)
book_11 = rothfuss.books.create(title:"The Wise Man's Fear", page_count: 994, year: 2011)

rowling = Author.create(name: "J.K. Rowling")

book_12 = rowling.books.create(title: "Harry Potter and the Philosopher's Stone", page_count: 309, year: 1997)

gaiman = Author.create(name:"Neil Gaiman")
pratchett = Author.create(name:"Terry Pratchett")

book_13 = Book.create(title: "Good Omens", page_count: 288, year: 1990, authors: [gaiman, pratchett])
book_14 = Book.create(title: "Probably a Great Fantasy Novel", page_count: 1000, year: 2018, authors: [martin, tolkien])

user_1 = User.create(username:"User1")
user_2 = User.create(username:"User2")
user_3 = User.create(username:"User3")
user_4 = User.create(username:"User4")

review_1 = Review.create(title:"Good review for A game of thrones",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
review_2 = Review.create(title:"Good review for book A Clash of Kings",review_text: "Great sequel", rating: 4, book: book_2, user: user_1 )
review_3 = Review.create(title:"Good review for book A Storm of Swords",review_text: "Could be shorter", rating: 4, book: book_3, user: user_2 )
review_4 = Review.create(title:"Bad review for The Hobbit",review_text: "I give it a 3", rating: 3, book: book_4, user: user_3 )

review_5 = Review.create(title:"Bad review for book 5",review_text: "hated", rating: 1, book: book_5, user: user_3 )
review_6 = Review.create(title:"Bad review for book 6",review_text: "hated", rating: 1, book: book_6, user: user_4 )
review_7 = Review.create(title:"Bad review for book 7",review_text: "hated", rating: 1, book: book_7, user: user_2 )
review_8 = Review.create(title:"Bad review for book 8",review_text: "Loved it", rating: 2, book: book_8, user: user_3 )

review_9 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_1 )
review_10 = Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 4, book: book_2, user: user_1 )
review_11= Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_3, user: user_1 )
review_12 = Review.create(title:"Good review for book 4",review_text: "Loved it", rating:4 , book: book_4, user: user_1 )


review_13 = Review.create(title:"Bad review for book 5",review_text: "hated it", rating: 1, book: book_5, user: user_2 )
review_14 = Review.create(title:"Bad review for book 6",review_text: "hated it", rating: 1, book: book_6, user: user_2 )
review_15 = Review.create(title:"Bad review for book 7",review_text: "hated it", rating: 1, book: book_7, user: user_2 )
review_16 = Review.create(title:"Bad review for book 8",review_text: "hated it", rating: 2, book: book_8, user: user_2 )

review_17 = Review.create(title:"Good review for book 1",review_text: "Loved it", rating: 5, book: book_1, user: user_3 )
review_18 = Review.create(title:"Good review for book 3",review_text: "Loved it", rating: 5, book: book_3, user: user_3 )
review_19 = Review.create(title:"Bad review for book 5",review_text: "hated it", rating: 1, book: book_5, user: user_3 )
review_20 = Review.create(title:"Bad review for book 7",review_text: "hated it", rating: 1, book: book_7, user: user_3 )
review_21 = Review.create(title:"Bad review for book 8",review_text: "hated it", rating: 2, book: book_8, user: user_3 )

review_22= Review.create(title:"Good review for book 2",review_text: "Loved it", rating: 5, book: book_2, user: user_4 )
review_23 = Review.create(title:"Good review for book 4",review_text: "Loved it", rating: 4, book: book_4, user: user_4 )
review_24 = Review.create(title:"Bad review for book 6",review_text: "hated it", rating: 1, book: book_6, user: user_4 )
