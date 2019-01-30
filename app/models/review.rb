class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :review_text

  validates :rating, presence: true,
  numericality: {only_integer: true, 
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5}
end
