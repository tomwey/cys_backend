class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.integer :uniq_id
      t.string :mobile, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :avatar, null: false, default: ''
      t.integer :_type, default: 1 # 艺人类型: 1表示入驻艺人, 2表示签约艺人
      t.string :school # 学校
      t.string :bio # 个人简介
      t.string :private_token # TOKEN
      t.boolean :verified, default: true
      t.timestamps null: false
    end
    add_index :performers, :uniq_id, unique: true
    add_index :performers, :mobile, unique: true
  end
end
