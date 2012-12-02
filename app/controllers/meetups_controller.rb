class MeetupsController < ApplicationController

  def show
    @idiom = Idiom.find(params[:idiom_id])
    @meetup = Meetup.find(params[:id])
  end

end