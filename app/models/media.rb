class Media < ActiveRecord::Base
  validates :_type, :title, :cover, :owner_id, presence: true
  
  mount_uploader :cover, CoverImageUploader
  mount_uploader :file, MediaFileUploader
  
  validate :require_file_upload
  def require_file_upload
    if self._type == 1 or self._type == 2
      if file.blank?
        errors.add(:base, '播放文件不能为空')
        return false
      end
    end
  end
  
  before_create :generate_uniq_id
  def generate_uniq_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..8]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
end
