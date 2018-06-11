class VoteItem < ActiveRecord::Base
  validates :performer_id, presence: true
  validates_uniqueness_of :performer_id, scope: :vote_id
  belongs_to :vote
  
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
