module VotesHelper

  # def proper_score(vote)
  #   if vote.voteable.total_score >= 0
  #     content_tag :span, vote.voteable.total_score, class: "positive"
  #   else
  #     content_tag :span, vote.voteable.total_score, class: 'negative'
  #   end
  # end

  
  def score(voteable)
    content_tag :span, voteable.total_score, 
      id: "#{voteable.class.to_s.downcase}_score_#{voteable.id}", 
      class: voteable.total_score >= 0 ? "positive" : "negative"
  end

  def correct_path(idiom, edit, vote, hash)
  	if vote.new_record?
      idiom_edit_votes_path(idiom, edit, vote, hash)
    else
      idiom_edit_vote_path(idiom, edit, vote, hash)
    end
  end
end
