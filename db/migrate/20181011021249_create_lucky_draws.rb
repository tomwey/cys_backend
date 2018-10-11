class CreateLuckyDraws < ActiveRecord::Migration
  def change
    create_table :lucky_draws do |t|
      t.integer :uniq_id
      t.string :title, null: false
      t.text :body
      t.boolean :opened, default: true
      t.timestamps null: false
    end
    add_index :lucky_draws, :uniq_id, unique: true
  end
end
