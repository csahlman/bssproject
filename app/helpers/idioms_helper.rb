module IdiomsHelper

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  #tags= Idiom.tag_counts
  # classes= s, m, l string array
  
  def upvote_button(voteable, upvoted)
    css_class = ""
    upvoted ? css_class = "badge badge-success" : css_class = ""
    link_to '+', upvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      id: "#{voteable.class.to_s.downcase}_upvote_#{voteable.id}", 
      class: (css_class + " upvote badge"), remote: true
  end

  def downvote_button(voteable, downvoted)
    css_class = ""
    downvoted ? css_class = "badge badge-warning" : css_class = ""
    link_to '-', downvote_path(voteable_type: voteable.class.to_s, voteable_id: voteable.id),
      id: "#{voteable.class.to_s.downcase}_downvote_#{voteable.id}", 
      class: (css_class + " downvote badge"), remote: true
  end

  def score(voteable)
    content_tag :span, voteable.total_score, 
      id: "#{voteable.class.to_s.downcase}_score_#{voteable.id}", 
      class: voteable.total_score >= 0 ? "positive" : "negative"
  end

  
end
