class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user 

  validates_presence_of :title
  validates_presence_of :review_text
  validates_presence_of :rating
end
