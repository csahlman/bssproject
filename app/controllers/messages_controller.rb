class MessagesController < ApplicationController
  before_filter :must_not_send_message_to_self
  def new
    @message= current_user.sent_messages.new
  end

  def create
    @conversation = Conversation.find_or_new(current_user.id, params[:user_id])
    @message = current_user.sent_messages.new
    @message.body = params[:message][:body]
    @message.receiver = @receiver
    if @message.save
      @conversation.add_message(@message)
      current_user.inbox.add_conversation(@conversation, true)
      @receiver.inbox.add_conversation(@conversation)
      respond_to do |f|
        f.html { redirect_to [current_user, current_user.inbox] }
        f.js
      end
    else
      render 'new'
    end

  end

  private

    def must_not_send_message_to_self
      @receiver= User.find(params[:user_id])
      redirect_to root_path, flash: 
        { error: "You can't message yourself" } if current_user == @receiver 
    end
end
