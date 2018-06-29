class UserVoteLog < ActiveRecord::Base
  after_create :update_vote_count
  def update_vote_count
    @vote_items = VoteItem.where(vote_id: self.vote_id, uniq_id: self.answers)
    @vote_items.each do |item|
      item.vote_count += 1
      item.save!
      
      if item.vote
        item.vote.vote_count += 1
        item.vote.save!
      end
      
    end
  end
end
