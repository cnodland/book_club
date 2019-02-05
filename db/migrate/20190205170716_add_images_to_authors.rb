class AddImagesToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :image, :string
  end
end
