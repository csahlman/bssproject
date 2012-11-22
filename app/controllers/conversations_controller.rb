class ConversationsController < ApplicationController
  before_filter :must_be_part_of_conversation, only: [ :show ]
  before_filter :must_be_own_inbox, only: [ :index ]

  def show
    @conversation.mark_as_read
    @other_user = @conversation.other_user(current_user)
  end

  def index
    @conversations = current_user.conversations
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

    def must_be_part_of_conversation
      @conversation = Conversation.find(params[:id])
      redirect_to root_path, flash: { error: "get out of there" } unless
        @conversation.messages.first.receiver == current_user || 
        @conversation.messages.first.sender == current_user
    end

    def must_be_own_inbox
      @user = User.find(params[:user_id])
      redirect_to root_path, flash: { error: "NOOOOPE" } unless
        @user == current_user
    end
end
