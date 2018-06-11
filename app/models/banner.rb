class Banner < ActiveRecord::Base
  validates :image, presence: true
  mount_uploader :image, BannerImageUploader
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc') }
  
  before_create :generate_uid_and_private_token
  def generate_uid_and_private_token
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..6]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
end
