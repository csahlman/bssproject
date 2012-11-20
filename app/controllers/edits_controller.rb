class EditsController < ApplicationController
  def index
    @idiom= Idiom.find(params[:idiom_id])
    @edits= @idiom.edits
    @contributors= @idiom.contributors_with_counts
    respond_to do |f|
      f.html
      f.json { render json: @edits }
    end  
  end

  def show
    @idiom= Idiom.find(params[:idiom_id])
    @edit= @idiom.edits.find(params[:id])
  end
end
