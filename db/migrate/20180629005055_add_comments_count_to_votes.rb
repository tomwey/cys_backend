class AddCommentsCountToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :comments_count, :integer, default: 0
  end
end
