class UserHobby < ActiveRecord::Base
  belongs_to :user
  belongs_to :hobby_id
end
