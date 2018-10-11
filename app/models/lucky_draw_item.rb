class LuckyDrawItem < ActiveRecord::Base
  validates :name, :quantity, :prize, presence: true
  belongs_to :lucky_draw
end
