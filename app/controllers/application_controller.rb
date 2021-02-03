class ApplicationController < ActionController::API
  include Pagy::Backend
  include DeclaredParams
  include Response
  include ErrorHandler
  include Authenticator
end
