class AddProfileImageToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :profile_image, :text
  end
end
