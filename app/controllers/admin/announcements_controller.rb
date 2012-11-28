class Admin::AnnouncementsController < Admin::BaseController

  def create
    @announcement = Announcement.new
    @announcement.message = params[:announcement][:message]
    @announcement.starts_at_text= params[:announcement][:starts_at_text]
    @announcement.ends_at_text = params[:announcement][:ends_at_text]
    @announcement.announcement_type = params[:announcement][:announcement_type]
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
    @announcement.announcement_type = params[:announcement][:announcement_type]
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

end
