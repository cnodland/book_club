require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :book}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :review_text}
    it {should validate_presence_of :rating}
  end
end
