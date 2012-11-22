class InboxesController < ApplicationController
  before_filter :must_be_own_inbox

  def show
    @initiated_conversations = @inbox.initiated_conversations
    @received_conversations = @inbox.received_conversations
    @conversations = @initiated_conversations + @received_conversations
    @new_message_count = @inbox.unread_count
  end

  private

    def must_be_own_inbox
      @inbox = Inbox.find(params[:id])
      redirect_to root_path unless current_user.inbox == @inbox
    end
end
