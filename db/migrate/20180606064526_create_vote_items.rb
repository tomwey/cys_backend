class CreateVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_items do |t|
      t.integer :vote_id
      t.integer :performer_id
      t.integer :vote_count, default: 0 # 得票数

      t.timestamps null: false
    end
    add_index :vote_items, :vote_id
    add_index :vote_items, :performer_id
  end
end
