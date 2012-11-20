class MessagesController < ApplicationController
  def new
    @receiver= User.find(params[:user_id])
    @message= current_user.sent_messages.new
  end

  def create
    @conversation= Conversation.find_or_new(current_user.id, params[:user_id])
    @message= current_user.sent_messages.new
    @message.body = params[:message][:body]
    @message.receiver = User.find(params[:user_id])
    if @message.save
      @conversation.messages << @message
      @conversation.save
      redirect_to @message.receiver
    else
      render 'new'
    end

  end
end
