class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate!, only: :create
  permited_params only: [:create], params: %i[username password]

  def create
    user = User.authenticate! username: username, password: password
    res Token.generate!(user), status: :created
  end
end
