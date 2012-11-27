module DownvotesHelper
  def downvote_button(voteable, css_class = nil)
    button_to '-', downvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      id: "#{voteable.class.to_s.downcase}_downvote_#{voteable.id}", 
      class: "#{css_class downvote}", remote: true
  end
end
