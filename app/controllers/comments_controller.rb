class CommentsController < ApplicationController
  def create
    @idiom= Idiom.find(params[:idiom_id])
    @comment= @idiom.comments.new
    @comment.message= params[:comment][:message]
    @comment.user= current_user
    if @comment.save
      respond_to do |f|
        f.html
        f.js
      end  
    else
      redirect_to @idiom, flash: { error: "Could not create comment" }
    end
  end

  def show
  end

  def index
  end

  def update
  end

  def destroy
  end
end
