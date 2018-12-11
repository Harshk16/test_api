class Reply < ApplicationRecord
  belongs_to :comment, counter_cache: true
  belongs_to :sender, class_name: 'User', counter_cache: true
  has_many :reacted_on, class_name: 'Reaction', foreign_key: "reacted_on_id", dependent: :destroy

  after_commit do |reply|
    ReplyBroadcastJob.perform_later reply.id
  end
end
