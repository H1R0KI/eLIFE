class RemoveProfileImageFromMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :profile_image, :text
  end
end
