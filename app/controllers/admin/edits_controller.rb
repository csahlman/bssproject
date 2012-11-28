class Admin::EditsController < Admin::BaseController

  def show
    @edit = Edit.find(params[:id])
  end

end
