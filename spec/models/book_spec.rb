require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :author_books}
    it {should have_many(:authors).through(:author_books)}
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :year}
  end
end
