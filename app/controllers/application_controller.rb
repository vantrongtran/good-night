class ApplicationController < ActionController::API
  include DeclaredParams
  include Response
  include ErrorHandler
  include Authenticator
end
