class AddAnswersToUserVoteLogs < ActiveRecord::Migration
  def change
    add_column :user_vote_logs, :answers, :string, array: true, default: []
    add_index :user_vote_logs, :answers, using: :gin
    remove_index :user_vote_logs, :vote_item_id
    remove_column :user_vote_logs, :vote_item_id
  end
end
