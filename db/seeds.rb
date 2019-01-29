Book.destroy_all
Author.destroy_all

martin = Author.create(name: "George R.R. Martin")
book_1 = Book.create(title: "A Game of Thrones", pages: 694, year: 1996)
book_2 = Book.create(title: "A Clash of Kings", pages: 761, year: 1998)
book_3 = Book.create(title: "A Storm of Swords", pages: 973, year: 2000)

tolkien = Author.create(name: "J.R.R. Tolkien")
book_4 = Book.create(title: "The Hobbit", pages: 310, year: 1937)
book_5 = Book.create(title:"The Silmarillion", pages: 365, year: 1977)

franzen = Author.create(name:"Jonathan Franzen")
gladwell = Author.create(name:"Malcolm Gladwell")

book_6 = Book.create(title:"The Corrections", pages: 568 , year: 2001)
book_7 = Book.create(title:"Purity", pages:563, year: 2015)

book_8 = Book.create(title:"The Tipping Point", pages:304 , year:2000)
book_9 = Book.create(title:"Outliers", pages: 304 , year: 2008)

rothfuss = Author.create(name:"Patrick Rothfuss")

book_10 = Book.create(title:"The Name of the Wind", pages: 662, year: 2007)
book_11 = Book.create(title:"The Wise Man's Fear", pages: 994, year: 2011)

rowling = Author.create(name: "J.K. Rowling")

book_12 = Book.create(title: "Harry Potter and the Philosopher's Stone", pages:309, year: 1997)

gaiman = Author.create(name:"Neil Gaiman")
pratchett = Author.create(name:"Terry Pratchett")

book_13 = Book.create(title: "Good Omens", pages: 288, year: 1990)
