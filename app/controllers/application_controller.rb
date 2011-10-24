class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def authenticate_admin!
      if Rails.env.production?
        credentials = {
          username: ENV['ADMIN_USERNAME'],
          password: ENV['ADMIN_PASSWORD_HASH']}
      else
        credentials = {
          username: "noah",
          password: "6057c39ce781ea2808fe4d1edb1c8610d07ef772"}
      end
      authenticate_or_request_with_http_basic do |username, password|
        username == credentials[:username] and
        Digest::SHA1.hexdigest(password) == credentials[:password]
      end
    end

    def current_user
    end
end
