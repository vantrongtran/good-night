module ErrorHandler
  extend ActiveSupport::Concern

  def error_handle error
    res({ error: { message: error.to_s.split("::").last.underscore.humanize } },
        status: error.class.status_code)
  end
end
