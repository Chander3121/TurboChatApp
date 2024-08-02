class WelcomeController < ApplicationController
  def index
    # @convos = Conversation.all
    @users = User.where.not(id: current_user.id)
  end
end
