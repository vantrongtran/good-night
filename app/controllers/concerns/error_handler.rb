module ErrorHandler
  extend ActiveSupport::Concern

  def error_handle error
    message = error.to_s.split("::").last.underscore.humanize
    status = error.class.respond_to?(:status_code) ? error.class.status_code : :bad_request

    res({ error: { message: message } }, status: status)
  end
end
