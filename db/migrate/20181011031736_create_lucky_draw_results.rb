class CreateLuckyDrawResults < ActiveRecord::Migration
  def change
    create_table :lucky_draw_results do |t|
      t.string :uniq_id
      t.integer :user_id, null: false
      t.integer :lucky_draw_id, null: false
      t.integer :lucky_draw_item_id, null: false

      t.timestamps null: false
    end
    add_index :lucky_draw_results, :uniq_id, unique: true
    add_index :lucky_draw_results, :user_id
    add_index :lucky_draw_results, :lucky_draw_id
    add_index :lucky_draw_results, :lucky_draw_item_id
  end
end
