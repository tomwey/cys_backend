class AddIpAndAddressAndLocationToUserVoteLogs < ActiveRecord::Migration
  def change
    add_column :user_vote_logs, :ip, :string
    add_column :user_vote_logs, :address, :string
    add_column :user_vote_logs, :location, :st_point, geographic: true
    add_index :user_vote_logs, :location, using: :gist
  end
end
