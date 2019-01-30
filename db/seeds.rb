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
