class CreateVoteViewLogs < ActiveRecord::Migration
  def change
    create_table :vote_view_logs do |t|
      t.integer :user_id
      t.integer :vote_id, null: false
      t.string :ip
      t.st_point :location, geographic: true
      t.string :address

      t.timestamps null: false
    end
    add_index :vote_view_logs, :user_id
    add_index :vote_view_logs, :vote_id
    add_index :vote_view_logs, :location, using: :gist
  end
end
