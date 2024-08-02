class MessagesController < ApplicationController
	before_action :set_conversation

	def create
		message = @convo.messages.create(message_params)
		whos_msg = message.user == current_user ? 'end' : 'start'
		Turbo::StreamsChannel.broadcast_append_to(
      "conversation_#{@convo.id}",
      partial: "messages/message",
      target:  "messages",
      locals:  { message: message, whos_msg: whos_msg}
    )
	end

	private
	def set_conversation
		@convo = Conversation.find(params[:conversation_id])
	end

	def message_params
		params.require(:message).permit(:user_id, :body)
	end
end
