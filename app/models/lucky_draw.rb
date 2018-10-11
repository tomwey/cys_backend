class LuckyDraw < ActiveRecord::Base
  validates :title, presence: true
  
  has_many :lucky_draw_checkins
  has_many :users, through: :lucky_draw_checkins
  
  has_many :lucky_draw_items, dependent: :destroy
  accepts_nested_attributes_for :lucky_draw_items, allow_destroy: true, reject_if: proc { |a| a[:name].blank? or a[:quantity].blank? or a[:prize].blank? }
  
  before_create :generate_uniq_id
  def generate_uniq_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..6]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
end
