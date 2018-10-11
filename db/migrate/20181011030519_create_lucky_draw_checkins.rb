class CreateLuckyDrawCheckins < ActiveRecord::Migration
  def change
    create_table :lucky_draw_checkins do |t|
      t.integer :user_id, null: false
      t.integer :lucky_draw_id, null: false

      t.timestamps null: false
    end
    add_index :lucky_draw_checkins, :user_id
    add_index :lucky_draw_checkins, :lucky_draw_id
    add_index :lucky_draw_checkins, [:user_id, :lucky_draw_id], unique: true
  end
end
