class CreateReview < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :review_text
      t.integer :rating

      t.timestamps
    end
  end
end
