class User < ApplicationRecord
  has_secure_password
  has_many :tokens, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def self.authenticate! username:, password:
    find_by(username: username).tap do |user|
      raise Api::Error::WrongUsernamePassword unless user&.authenticate password
    end
  end
end
