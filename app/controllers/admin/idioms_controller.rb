class Admin::IdiomsController < ApplicationController
  def show
    @idiom = Idiom.find(params[:id])
    @vote = @idiom.votes.find_or_initialize_by_user_id(current_user.id)
    @tag_for_voting = @idiom.random_tag
    @tag_vote = @tag_for_voting.votes.find_or_initialize_by_user_id(current_user.id)
    respond_to do |f|
      f.html
      f.json { render json: @idiom}
    end  
  end

  def index
    @idioms = Idiom.all
  end

  def edit
  end

  private

    def redirect_unless_admin
      redirect_to root_path, flash: { error: "Error, you don't have access" } unless
        current_user.admin?
    end  
end
