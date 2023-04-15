class AddGenreToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :genre, :integer
  end
end
