class Admin::CommentsController < Admin::BaseController

  def show
    @comment = Comment.find(params[:id])

    respond_to do |f|
      f.js
    end
  end

end
