module MessagesHelper

  def sent_or_received(message)
    message.sender == current_user ? "Sent " : "Received "
  end
end
