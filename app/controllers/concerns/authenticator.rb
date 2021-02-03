module Authenticator
  extend ActiveSupport::Concern

  attr_accessor :current_user

  included do
    before_action :authenticate!
  end

  def authenticate!
    @current_user = current_token&.user
    raise Api::Error::Unauthenticated unless current_user
  rescue StandardError => e
    error_handle e
  end

  def token_on_header
    auth_header = request.headers[Settings.auth.token.header_key]
    auth_header&.scan(/^#{Settings.auth.token.header_prefix} (.+)$/i)&.flatten&.[]0
  end

  def current_token
    Token.find_token! token_on_header
  end
end
