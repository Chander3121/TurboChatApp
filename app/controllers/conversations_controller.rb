class ConversationsController < ApplicationController
  before_action :set_user, only: [:start_convo]

  def show
  	@convo = Conversation.find(params[:id])
    @messages = @convo.messages.where.not(body: nil)
    @message = @convo.messages.new
  end

  def start_convo
    @convo = find_or_create_conversation
    redirect_to conversation_path(@convo)
  end

  def messages
    @convo = Conversation.find(params[:id])
    @messages = @convo.messages
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def find_or_create_conversation
    Conversation.find_by(
      "(sender_id = :current_user_id AND receiver_id = :user_id) OR (sender_id = :user_id AND receiver_id = :current_user_id)",
      current_user_id: current_user.id,
      user_id: @user.id
    ) || Conversation.create(sender_id: current_user.id, receiver_id: @user.id)
  end
end
