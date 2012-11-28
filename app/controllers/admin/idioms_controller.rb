class Admin::IdiomsController < Admin::BaseController
  def show
    @idiom = Idiom.find(params[:id])
    respond_to do |f|
      f.html
      f.js
      f.json { render json: @idiom}
    end  
  end

  def index
    @idioms = Idiom.all
  end

  def edit
  end

  def update
    @idiom = Idiom.find(params[:id])
    @idiom.update_column(:resolved, true) if params[:resolved]
  end

end
