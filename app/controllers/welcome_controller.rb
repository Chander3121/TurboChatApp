class WelcomeController < ApplicationController
  def index
    @convos = current_user.conversations
    @users = User.where.not(id: current_user.id)
  end
end
