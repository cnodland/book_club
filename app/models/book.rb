class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :year
end
