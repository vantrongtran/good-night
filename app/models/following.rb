class Following < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: "User"

  validates :user, presence: true, uniqueness: { scope: :following_user_id }
  validates :following_user, presence: :true
end
