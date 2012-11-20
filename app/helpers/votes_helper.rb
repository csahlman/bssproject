module VotesHelper

  def proper_score(vote)
    if vote.voteable.total_score >= 0
      content_tag :span, vote.voteable.total_score, class: "positive"
    else
      content_tag :span, vote.voteable.total_score, class: 'negative'
    end
  end
end
