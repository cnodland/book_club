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

  # method to order ratings
  #only needs to be tested on model method, not necessarily feature
end
