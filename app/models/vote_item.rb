class VoteItem < ActiveRecord::Base
  validates :performer_id, presence: true
  validates_uniqueness_of :performer_id, scope: :vote_id
  belongs_to :vote
end
