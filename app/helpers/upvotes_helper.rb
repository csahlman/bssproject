module UpvotesHelper
  def upvote_button(voteable, upvoted)
    css_class = ""
    upvoted ? css_class = "badge badge-success" : css_class = ""
    link_to '+', upvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      method: :post, id: "#{voteable.class.to_s.downcase}_upvote_#{voteable.id}", 
      class: (css_class + " upvote badge"), remote: true
  end
end
