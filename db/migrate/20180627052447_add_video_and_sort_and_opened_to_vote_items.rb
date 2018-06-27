class AddVideoAndSortAndOpenedToVoteItems < ActiveRecord::Migration
  def change
    add_column :vote_items, :uniq_id, :integer
    add_column :vote_items, :video, :string
    add_column :vote_items, :body, :text
    add_column :vote_items, :sort, :integer, default: 0
    add_index :vote_items, :sort
    add_column :vote_items, :opened, :boolean, default: true
    add_index :vote_items, :uniq_id, unique: true
  end
end
