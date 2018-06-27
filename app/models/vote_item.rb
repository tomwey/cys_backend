class VoteItem < ActiveRecord::Base
  validates :performer_id, :video, presence: true
  # validates_uniqueness_of :performer_id, scope: :vote_id
  belongs_to :vote
  
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
  
  def perform
    @perform ||= Performer.find_by(uniq_id: self.performer_id)
  end
  
  def percent
    return '0' if vote_count == 0
    return '0' if vote.blank? or vote.vote_count == 0
    num = ((vote_count.to_f / vote.vote_count.to_f) * 100).to_i
    num.to_s
  end
  
end
