class AddViewCountAndVideosToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :view_count, :integer, default: 0
    add_column :votes, :video, :string
  end
end
