class AddColumnsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :name, :string
    add_column :members, :age, :integer
    add_column :members, :composition, :integer
    add_column :members, :is_deleted, :boolean, default: false
  end
end
