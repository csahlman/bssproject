class UpvotesController < ApplicationController

  def create
    @vote = current_user.votes.find_or_initialize_by_voteable_id(params[:voteable_id])
    @vote.user = current_user
    @vote.downvote

    respond_to do |f|
      f.html
      f.js
    end
  end

end