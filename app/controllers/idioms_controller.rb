class IdiomsController < ApplicationController
  skip_before_filter :authenticate, only: [:show, :index]

  def new
    @idiom = Idiom.new
  end

  def create
    @idiom = Idiom.new
    @idiom.attributes = params[:idiom]
    @idiom.tag_list = params[:idiom][:tag_list] if params[:idiom][:tag_list]
    @idiom.user = current_user

    if @idiom.save
      @edit = @idiom.create_new_edit(current_user)
      redirect_to @idiom, flash: { notice: "#{@idiom.title} created" }
    else
      render 'new'
    end
  end

  def update
    @idiom = Idiom.includes([:tags]).find(params[:id])
    @edit = @idiom.create_new_edit(current_user)
    @idiom.attributes = params[:idiom]
    @idiom.tag_list = params[:idiom][:tag_list] if params[:idiom][:tag_list]
    EditMailer.idiom_edit_mailer(current_user, @idiom, @edit).deliver if 
      current_user.receive_emails?
    if @idiom.save
      redirect_to @idiom, flash: { notice: "#{@idiom.title} updated" }
    else
      render 'edit'
    end
  end

  def edit
    @idiom= Idiom.find(params[:id])
  end

  def show
    @idiom = Idiom.includes(:tags, comments: { votes: :user }).find(params[:id])
    if signed_in?
      @meetups = Meetup.find_or_create_new_meetups(@idiom, current_user.zip_code)
    end
    if @idiom.tags.any? && signed_in?
      @tag_for_voting = @idiom.random_tag
    end
    respond_to do |f|
      f.html
      f.json { render json: @idiom }
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

end
