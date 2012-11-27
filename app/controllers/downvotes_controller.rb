class DownvotesController < ApplicationController

  def create
    @voteable_class = params[:voteable_type]
    @voteable = @voteable_class.classify.constantize.find(params[:voteable_id])
    @vote = @voteable.votes.find_or_initialize_by_user_id(current_user.id)
    @vote.user = current_user
    @vote.downvote

    respond_to do |f|
      f.html
      f.js
    end
  end
end