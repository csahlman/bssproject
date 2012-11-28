class Admin::EditsController < Admin::BaseController

  def show
    @edit = Edit.find(params[:id])
  end

  def destroy
    @edit = Edit.find(params[:id])
    @edit.destroy
  end

end
