class MessagesController < ApplicationController
  before_filter :must_not_send_message_to_self, except: [ :show, :index ]
  before_filter :must_be_part_of_message, only: [ :show ]
  before_filter :must_be_own_inbox, only: [ :index ]

  def new
    @message= current_user.sent_messages.new
  end

  def create
    # look into observer
    @message = current_user.sent_messages.new
    @message.body = params[:message][:body]
    @message.receiver = @receiver
    if @message.save
      respond_to do |f|
        f.html { redirect_to [current_user, @conversation] }
        f.js
      end
    else
      render 'new'
    end
  end

  def show
    @receiver = @message.other_user(current_user)
    @conversation = Message.conversation(current_user.id, @receiver.id)
  end

  def index
    @conversations = Message.all_conversations(current_user)
    @new_message_count = current_user.unread_count
  end

  private

    def must_be_own_inbox
      @user = User.find(params[:user_id])
      redirect_to root_path unless @user == current_user      
    end

    def must_be_part_of_message
      @message = Message.find(params[:id])
      redirect_to root_path, flash: { error: "No access" } unless @message.receiver == current_user || 
        @message.sender == current_user
    end

    def must_not_send_message_to_self
      @receiver = User.find(params[:user_id])
      redirect_to root_path, flash: 
        { error: "You can't message yourself" } if current_user == @receiver 
    end
end
