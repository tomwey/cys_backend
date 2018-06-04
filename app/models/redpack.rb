class Redpack < ActiveRecord::Base
  validates :owner_id, :total_money, :sent_count, :use_type, :theme_id, presence: true
  
  # mount_uploader :bg_audio, AudioUploader
  
  before_create :generate_unique_id
  def generate_unique_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..8]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
  def merchant
    @merchant ||= Merchant.find_by(uniq_id: self.merch_id)
  end
  
  def user
    @user ||= User.find_by(uid: self.owner_id)
  end
  
  def theme
    @theme ||= RedpackTheme.find_by(uniq_id: self.theme_id)
  end
  
  def audio
    @audio ||= RedpackAudio.find_by(uniq_id: self.audio_id)
  end
  
  def sign_val
    self.sign.join(',')
  end
  
  validate :total_money_large_sent_money, on: :create
  def total_money_large_sent_money
    if total_money <= sent_money
      errors.add(:base, "红包总金额必须要大于#{sent_money / 100.0}元")
      return false
    end
  end
  
  # validate :check_min_value_if_is_cash
  # def check_min_value_if_is_cash
  #   if self.use_type == 1
  #     # puts self.min_value
  #     if self.min_value.blank? or self.min_value < limit_min_value
  #       errors.add(:base, "现金红包最小值不能低于#{limit_min_value / 100}元")
  #       return false
  #     end
  #   end
  # end
  
  def is_cash?
    self.use_type == 1
  end
  
  def left_money
    self.total_money - self.sent_money
  end
  
  def limit_min_value
    if self.use_type == 1
      100
    elsif self.use_type == 2
      10
    else
      0
    end
  end
  
  def money=(val)
    if val.present?
      if self._type == 0
        self.total_money = val.to_f * 100
      else
        self.total_money = val.to_f * 100 * self.total_count
      end
    end
  end
  
  def money
    return nil if self.total_money.blank?
    if self._type == 0
      self.total_money / 100.0
    else
      tmp = self.total_money / 100.0
      tmp / self.total_count
    end
  end
  
  def min_money=(val)
    if val.present? && self._type == 0 && val.to_f >= 0.01
      if val.to_f < 0.01
        errors.add(:base, '不能低于0.01元')
        return
      end
      
      self.min_value = val.to_f * 100
    end
  end
  
  def min_money
    if self._type == 0
      if self.min_value.blank?
        return nil
      else
        return self.min_value / 100.0
      end
    else
      return nil
    end
  end
  
  def sign_val=(val)
    if val.present?
      self.sign = val.split(/(?:\||\,)/)
    end
  end
  
  def sign_val
    if sign.empty?
      return nil
    else
      return sign.join(',')
    end
  end
  
  def random_money
    if self._type != 0
      return self.total_money / self.total_count
    end
    
    return _calc_random_money
  end
  
  def redpack_image_url
    if theme.blank?
      ''
    else
      qrcode_image_url = "#{SiteConfig.main_server}/qrcode?text=#{self.detail_url}"
      theme.watermark_image(qrcode_image_url, self.subject || '恭喜发财，大吉大利')
    end
  end
  
  def detail_url
    ShortUrl.sina("#{SiteConfig.front_url}/?rid=#{self.uniq_id}")
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
  def change_sent_stat!(money)
    self.sent_count += 1
    self.sent_money += money
    self.save!
  end
  
  def has_left?
    self.total_money > self.sent_money
  end
  
  def calc_min_value
    @calc_min_value ||= (self.total_money.to_f / self.total_count).floor
  end
  
  private
  def _calc_random_money
    remain_size = self.total_count - self.sent_count
    remain_money = (self.total_money - self.sent_money)
    
    if remain_size == 0
      return 0
    end
    
    if remain_size == 1
      return remain_money
    end
    
    tmp_remain_money = remain_money.to_f / 100.00
    
    min = self.min_value || calc_min_value
    
    tmp_min = min.to_f / 100.00
    
    max = tmp_remain_money.to_f / remain_size * 2
    temp_money = SecureRandom.random_number * max
    temp_money = temp_money < tmp_min ? tmp_min : temp_money
    
    temp_money = (temp_money * 100).floor
    temp_money
  end
  
end
