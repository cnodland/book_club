class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :review_text
  validates_presence_of :rating 
end
