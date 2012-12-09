class InboxesController < ApplicationController
  before_filter :must_be_own_inbox

  def show
    @initiated_conversations = current_user.inbox.initiated_conversations
    @received_conversations = current_user.inbox.received_conversations
    @conversations = @initiated_conversations + @received_conversations
    @new_message_count = current_user.inbox.unread_count
  end

  private

    def must_be_own_inbox
      @user = User.includes(:inbox).find(params[:user_id])
       redirect_to root_path unless current_user == @user
    end
end
