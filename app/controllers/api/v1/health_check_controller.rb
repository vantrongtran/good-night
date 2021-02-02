class Api::V1::HealthCheckController < ApplicationController
  def index
    res({ status: 'alive' })
  end
end
