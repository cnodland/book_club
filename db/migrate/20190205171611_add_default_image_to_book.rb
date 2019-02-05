class AddDefaultImageToBook < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :image, :text, default: "https://timedotcom.files.wordpress.com/2015/06/521811839-copy.jpg"
  end
end
