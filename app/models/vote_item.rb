class VoteItem < ActiveRecord::Base
  validates :performer_id, presence: true
  validates_uniqueness_of :performer_id, scope: :vote_id
  belongs_to :vote
  
  def perform
    @perform ||= Performer.find_by(uniq_id: self.performer_id)
  end
end
