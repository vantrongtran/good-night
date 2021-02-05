class User < ApplicationRecord
  has_secure_password

  has_many :tokens, dependent: :destroy
  has_many :daily_sleeping_times, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :following_users, through: :followings, source: :following_user
  has_many :followers, foreign_key: "following_user_id", class_name: "Following",
                       dependent: :destroy
  has_many :follower_users, through: :followers, source: :user

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def self.authenticate! username:, password:
    find_by(username: username).tap do |user|
      raise Api::Error::WrongUsernamePassword unless user&.authenticate password
    end
  end
end
