class AddLikesCountToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :likes_count, :integer, default: 0
  end
end
