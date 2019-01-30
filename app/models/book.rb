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

  def self.sort_avg_rating(order)
    Book.joins(:reviews)
    .select("books.*, avg(reviews.rating) as avg_rating")
    .group(:id)
    .order("avg_rating #{order}" )
    .limit(3)

  end
end
