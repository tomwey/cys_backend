class VoteViewLog < ActiveRecord::Base
  after_create :increment_vote_view_count
  def increment_vote_view_count
    if vote
      vote.view_count += 1
      vote.save!
    end
  end
  
  def vote
    @vote ||= Vote.find_by(uniq_id: self.vote_id)
  end
end
