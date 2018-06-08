class Media < ActiveRecord::Base
  validates :title, :cover, :owner_id, presence: true
  
  # has_one :radio_content, dependent: :destroy # 保存电台的额外信息，比如：作词，作曲，原唱，歌词
  # accepts_nested_attributes_for :radio_content, allow_destroy: true,
  #   reject_if: proc { |o| o[:content].blank? }
  
  mount_uploader :cover, CoverImageUploader
  # mount_uploader :file, MediaFileUploader
  
  validate :require_file_upload, on: :create
  def require_file_upload
    if self._type == 1 or self._type == 2
      if file.blank?
        errors.add(:base, '播放文件不能为空')
        return false
      end
    end
  end
  
  def owner
    @owner ||= Performer.find_by(uniq_id: self.owner_id)
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
    self._type = 2
  end
  
  def media_file_url
    return '' if self.file.blank?
    origin_file_url = 'http://' + SiteConfig.qiniu_bucket_domain + "/uploads/media/" + self.file
    Qiniu::Auth.authorize_download_url(origin_file_url)
  end
  
end
