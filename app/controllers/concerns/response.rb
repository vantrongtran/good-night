module Response
  extend ActiveSupport::Concern

  def res resources, extra_params = {}
    render extra_params.merge json: resources
  end

  def pagination_dict object
    {
      current_page: object.page,
      next_page: object.next,
      prev_page: object.prev,
      last_page: object.last,
      total_count: object.count
    }
  end
end
