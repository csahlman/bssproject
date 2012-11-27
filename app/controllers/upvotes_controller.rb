class UpvotesController < ApplicationController

  def create
    @vote = Vote.find(params[:voteable_id])
    @vote.user = current_user
    @vote.downvote

    respond_to do |f|
      f.html
      f.js
    end
  end

end