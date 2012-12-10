class MessagesController < ApplicationController
  before_filter :must_not_send_message_to_self, except: [ :index ]
  def new
    @message= current_user.sent_messages.new
  end

  def create
    # look into observer
    @conversation = Conversation.find_or_new(current_user.id, params[:user_id])
    @message = current_user.sent_messages.new
    @message.body = params[:message][:body]
    @message.receiver = @receiver
    if @message.save
      @conversation.add_message(@message)
      current_user.inbox.add_conversation(@conversation, true)
      @receiver.inbox.add_conversation(@conversation)
      respond_to do |f|
        f.html { redirect_to [current_user, @conversation] }
        f.js
      end
    else
      render 'new'
    end
  end

  def show
    @conversation = Message.conversation(current_user, @receiver)
  end

  def index
    @conversations = Message.all_conversations(current_user)
    @new_message_count = current_user.unread_count
  end

  private

    def must_not_send_message_to_self
      @receiver= User.find(params[:user_id])
      redirect_to root_path, flash: 
        { error: "You can't message yourself" } if current_user == @receiver 
    end
end
