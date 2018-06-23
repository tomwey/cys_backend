class ChangeIndexesForLikes < ActiveRecord::Migration
  def change
    remove_index :likes, [:likeable_type, :likeable_id]
    add_index :likes, :likeable_type
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
