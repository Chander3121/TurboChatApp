class MessagesController < ApplicationController
	before_action :set_conversation

	def index
		@convo = Conversation.find(params[:conversation_id])
		@message = @convo.messages.new
		@messages = @convo.messages.where.not(body: nil)
	end

	def create
		message = @convo.messages.create(message_params)

		Turbo::StreamsChannel.broadcast_append_to(
      "conversation_#{@convo.id}",
      partial: "messages/message",
      target:  "messages",
      locals:  { message: message, current_user: current_user}
    )

    # Turbo::StreamsChannel.broadcast_update_to(
    #   "conversation_last_msg_#{@convo.id}",
    #   partial: "messages/last_msg",
    #   target:  "convo_#{@convo.id}_last_msg",
    #   locals:  { convo: @convo}
    # )
	end

	private
	def set_conversation
		@convo = Conversation.find(params[:conversation_id])
	end

	def message_params
		params.require(:message).permit(:user_id, :body)
	end
end
