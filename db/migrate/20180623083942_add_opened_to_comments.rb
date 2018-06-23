class AddOpenedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :opened, :boolean, default: true
    add_column :comments, :reply_count, :integer, default: 0
    add_column :comments, :ip, :string
    add_column :comments, :location, :st_point, geography: true
    add_index :comments, :location, using: :gist
    add_column :comments, :address, :string 
  end
end
