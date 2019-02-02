class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :year

  def average_rating
    if reviews.count >= 1
      reviews.average(:rating).round(2)
    else
      0
    end
  end

  def self.sort_avg_rating(order, limit = 50)
    Book.joins(:reviews)
    .select("books.*, avg(reviews.rating) as avg_rating")
    .group(:id)
    .order("avg_rating #{order}" )
    .limit(limit)
  end

  def self.sort_num_reviews(order)
    Book.joins(:reviews)
    .select("books.*, count(reviews) as num_reviews")
    .group(:id)
    .order("num_reviews #{order}")
    .limit(50)
  end

  def sort_three_reviews(order)
    Review.where(book: self)
    .order(rating: order)
    .limit(3)
  end

  def multiple_authors(undesired_author)
    binding.pry
    Book.joins(:authors)
    .select("authors")
    .where(id: self.id).exclude(authors: undesired_author)
  end
end
