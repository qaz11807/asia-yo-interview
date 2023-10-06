class ApplicationController < ActionController::API
  def success_response(data)
    render status: 200, json: { status: 'Success' }.merge(data)
  end

  def error_response(status_code, message: nil)
    data = { status: 'Failed' }
    data.merge!({ message: message }) if message.present?
    render status: status_code, json: data
  end
end
