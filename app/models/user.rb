class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :username

  def self.top_three_reviewers
     User.joins(:reviews)
    .select("users.*, count(reviews.user_id) as num_reviews")
    .group(:id)
    .order("num_reviews desc")
    .limit(3)

  end
end
