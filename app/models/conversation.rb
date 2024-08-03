class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  has_many :messages, dependent: :destroy

  def other_user(user)
    another_user = convo_users - [user]
    another_user.first
  end

  def convo_users
    [sender, receiver]
  end
end
