class Message < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :channel_id
end
