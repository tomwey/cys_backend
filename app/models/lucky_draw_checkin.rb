class LuckyDrawCheckin < ActiveRecord::Base
  validates :user_id, :lucky_draw_id, presence: true
  belongs_to :user
  belongs_to :lucky_draw
end
