class VotesController < ApplicationController
  before_filter :get_voteable

  def create
    @vote = @voteable.votes.new
    @vote.vote_value = params[:vote][:vote_value]
    @vote.user = current_user
    if @vote.save
      respond_to do |f|
        # f.html { redirect_to @vote.voteable }
        f.js { }
        f.json { render json: @vote }
      end  
    else
      respond_to do |f|
        f.html { redirect_to root_path, flash: { error: "asdf" } }
      end
    end
  end

  def show
  end

  def index
    @votes= @voteable.votes
  end

  def update
    @vote = @voteable.votes.find_by_user_id(current_user.id)
    @vote.vote_value = params[:vote][:vote_value]
    if @vote.save
      respond_to do |f|
        f.html
        f.js
        f.json
      end
    else
      redirect_to root_path
    end
  end

  def upvote
    @vote = @voteable.votes.find_or_initialize_by_user_id(current_user.id)
    @vote.save_upvote

    respond_to do |f|
      f.html
      f.js
    end
  end

  def downvote
    @vote = @voteable.votes.find_or_initialize_by_user_id(current_user.id)
    @vote.save_downvote

    respond_to do |f|
      f.html
      f.js
    end    
  end

  private

    # def load_voteable
    #   klass = [Idiom, Comment, Edit].detect { |c| params["#{c.name.underscore}_id"]}
    #   @voteable = klass.find(params["#{klass.name.underscore}_id"])
    # end

    def get_voteable
      @voteable = params[:voteable].classify.constantize.find(voteable_id)
    end

    def voteable_id
      params[(params[:voteable].singularize + "_id").to_sym]
    end
end
