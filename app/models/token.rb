class Token < ApplicationRecord
  include SecuredGenerator

  has_secure_token
  belongs_to :user

  validates :expires_at, presence: true
  validates :token, uniqueness: true

  def expired?
    expires_at <= Time.zone.now
  end

  def self.generate! user
    create! token: unique_random(:token, Settings.auth.token.length),
            expires_at: Settings.auth.token.expires_in.second.from_now,
            user: user
  end

  def self.find_token! token
    find_by(token: token).tap do |user_token|
      raise Api::Error::TokenExpired if user_token&.expired?
    end
  end
end
