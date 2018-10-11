class CreateLuckyDrawItems < ActiveRecord::Migration
  def change
    create_table :lucky_draw_items do |t|
      t.integer :lucky_draw_id
      t.string :name, null: false
      t.integer :quantity, null: false
      t.string :prize, null: false
      t.datetime :started_at
      t.boolean :opened, default: true
      t.integer :sort, default: 0

      t.timestamps null: false
    end
    add_index :lucky_draw_items, :lucky_draw_id
    add_index :lucky_draw_items, :sort
  end
end
