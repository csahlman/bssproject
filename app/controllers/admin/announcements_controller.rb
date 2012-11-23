class Admin::AnnouncementsController < ApplicationController
  before_filter :redirect_unless_admin

  def create
    @announcement = Announcement.new
    @announcement.message = params[:announcement][:message]
    @announcement.starts_at_text= params[:announcement][:starts_at_text]
    @announcement.ends_at_text = params[:announcement][:ends_at_text]
    if @announcement.save
      respond_to do |f|
        f.html { redirect_to admin_announcements_path }
      end
    else
      redirect_to admin_announcements_path
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    @announcement.message = params[:announcement][:message]   
    @announcement.starts_at_text = params[:announcement][:starts_at_text]
    @announcement.ends_at_text = params[:announcement][:ends_at_text]
    if @announcement.save
      respond_to do |f|
        f.html { redirect_to admin_announcements_path }
      end
    else
      redirect_to admin_announcements_path
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    respond_to do |f|
      f.js
    end
  end

  def index
    @current_announcements = Announcement.current
    @future_announcements = Announcement.future
    @previous_announcements = Announcement.past
  end

  private

    def redirect_unless_admin
      redirect_to root_path, flash: { error: "Error, you don't have access" } unless
        current_user.admin?
    end  
end
