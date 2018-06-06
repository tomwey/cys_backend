class CreateUserVoteLogs < ActiveRecord::Migration
  def change
    create_table :user_vote_logs do |t|
      t.integer :user_id, null: false
      t.integer :vote_id, null: false
      t.integer :vote_item_id, null: false

      t.timestamps null: false
    end
    add_index :user_vote_logs, :user_id
    add_index :user_vote_logs, :vote_id
    add_index :user_vote_logs, :vote_item_id
  end
end
