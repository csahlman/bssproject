module UpvotesHelper
  def upvote_button(voteable, css_class = nil)
    button_to '+', upvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      id: "#{voteable.class.to_s.downcase}_upvote_#{voteable.id}", class: css_class, 
      remote: true
  end
end
