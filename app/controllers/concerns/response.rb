module Response
  extend ActiveSupport::Concern

  def res resources, extra_params = {}
    render extra_params.merge json: resources
  end
end
