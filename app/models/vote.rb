class Vote < ActiveRecord::Base
  validates :title, :expired_at, presence: true
  
  has_many :vote_items, dependent: :destroy
  accepts_nested_attributes_for :vote_items, allow_destroy: true, 
    reject_if: proc { |o| o[:performer_id].blank? }
  
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
  
  validate :check_vote_items
  def check_vote_items
    if vote_items.empty?
      errors.add(:base, '至少需要一个填入一个投票选项')
      return false
    end
  end
  
end
