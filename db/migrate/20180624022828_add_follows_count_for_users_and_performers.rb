class AddFollowsCountForUsersAndPerformers < ActiveRecord::Migration
  def change
    add_column :users, :follows_count, :integer, default: 0
    add_column :performers, :follows_count, :integer, default: 0
  end
end
