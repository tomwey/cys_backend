class ChangeColumnsForPerformers < ActiveRecord::Migration
  def change
    change_column :performers, :bio, :text
    add_column :performers, :height, :string # 身高
    add_column :performers, :weight, :string # 体重
    add_column :performers, :birth, :string  # 生日
  end
end
