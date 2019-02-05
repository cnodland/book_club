class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books, dependent: :destroy
  has_many :reviews, dependent: :destroy

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
    Book.left_outer_joins(:reviews)
    .select("books.*, avg(reviews.rating) as avg_rating")
    .group(:id)
    .order("avg_rating #{order}" )
    .limit(limit)
  end

  def self.sort_num_reviews(order)
    Book.left_outer_joins(:reviews)
    .select("books.*, count(reviews) as num_reviews")
    .group(:id)
    .order("num_reviews #{order}")
    .limit(50)
  end

  def sort_three_reviews(order, limit = 3)

    Review.where(book: self)
    .order(rating: order)
    .limit(limit)
  end

  def co_authors(undesired_author)
    authors.where.not(id: undesired_author.id)
  end

  def top_review
    if reviews.length >= 1
      return sort_three_reviews('desc',1).first
    end
  end
end
