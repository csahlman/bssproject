module DownvotesHelper

  def downvote_button(voteable)
    downvoted = voteable.downvoted_by_user?(current_user)
    css_class = ""
    downvoted ? css_class = "badge badge-important" : css_class = ""
    link_to '-', downvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      method: :post, id: "#{voteable.class.to_s.downcase}_downvote_#{voteable.id}", 
      class: (css_class + " downvote badge"), remote: true
  end
  
end
