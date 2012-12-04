class Admin::CommentsController < Admin::BaseController
  before_filter :find_comment

  def show
  end

  def destroy
    @comment.destroy    
  end

  def edit
  end

  def update
  end


  private

    def find_comment
      @comment = Comment.find(params[:id])   
    end
end
