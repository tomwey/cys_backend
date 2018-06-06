class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :uniq_id
      t.string :title, null: false, default: ''
      t.text :body
      t.string :body_url
      t.datetime :expired_at, null: false
      t.boolean :opened, default: true
      t.integer :_type, default: 1 # 投票类型，1表示单选 2表示多选
      t.integer :vote_count, default: 0 # 总投票数
      t.integer :sort, default: 0 # 显示顺序，保留字段

      t.timestamps null: false
    end
    add_index :votes, :uniq_id, unique: true
  end
end
