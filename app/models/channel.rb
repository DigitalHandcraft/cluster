class Channel < ActiveRecord::Base
  belongs_to :user
  belongs_to :interest
  has_many :messages
end
