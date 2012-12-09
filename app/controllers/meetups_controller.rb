class MeetupsController < ApplicationController

  def show
    @idiom = Idiom.find(params[:idiom_id])
    @meetup = Meetup.find(params[:id])
  end

  def create
    @meetups = Meetup.find_or_create_new_meetups(Idiom.find(params[:idiom_id]), params[:zip_code])
    respond_to do |f|
      f.json do 
        render json: @meetups.map { |meetup| { link_url: idiom_meetup_url(meetup.idiom.id, meetup.id),
          name: meetup.name }}
      end 
    end
  end

end