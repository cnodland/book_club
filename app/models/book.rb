class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :year

  has_many :author_books
  has_many :authors, through: :author_books
end
