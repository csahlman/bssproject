class IdiomsController < ApplicationController
  skip_before_filter :authenticate, only: [:show, :index]

  def new
    @idiom= Idiom.new
  end

  def create
    @idiom= Idiom.new
    @idiom.title = params[:idiom][:title]
    @idiom.description = params[:idiom][:description]
    @idiom.description_right = params[:idiom][:description_right]
    @idiom.tag_list = params[:idiom][:tag_list] if params[:idiom][:tag_list]
    @idiom.user = current_user

    if @idiom.save
      make_edit(@idiom)
      redirect_to @idiom, flash: { notice: "#{@idiom.title} created"}
    else
      render 'new'
    end
  end

  def destroy
    @idiom = Idiom.find(params[:id])
  end

  def update
    @idiom = Idiom.find(params[:id])
    make_edit(@idiom)
    EditMailer.idiom_edit_mailer(current_user, @idiom, @edit).deliver
    @idiom.title = params[:idiom][:title]
    @idiom.description = params[:idiom][:description]
    @idiom.description_right = params[:idiom][:description_right]
    if @idiom.save
      redirect_to @idiom, flash: { notice: "#{@idiom.title} updated"}
    else
      render 'edit'
    end
  end

  def edit
    @idiom= Idiom.find(params[:id])
  end

  def show
    @idiom = Idiom.find(params[:id])
    if signed_in?
      @vote = @idiom.votes.find_or_initialize_by_user_id(current_user.id)
    end
    @report = @idiom.reports.new
    if @idiom.tags.any? && signed_in?
      @tag_for_voting = @idiom.random_tag
      @tag_vote = @tag_for_voting.votes.find_or_initialize_by_user_id(current_user.id)
    end
    respond_to do |f|
      f.html
      f.json { render json: @idiom}
    end  
  end

  def index
    if params[:tag]
      @idioms= Idiom.tagged_with(params[:tag])
    else
      @idioms= Idiom.all
    end

    respond_to do |f|
      f.html
      f.json { render json: @idioms }
    end
  end

  private

    def make_edit(idiom)
      @edit= idiom.edits.new
      @edit.edited_at= idiom.updated_at
      @edit.user= current_user
      @edit.description= idiom.description
      @edit.save!      
    end
end
