class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def authenticate_admin!
      authenticate_or_request_with_http_basic do |username, password|
        username == "noah" and
        Digest::SHA1.hexdigest(password) == "6057c39ce781ea2808fe4d1edb1c8610d07ef772"
      end
    end

    def current_user
    end
end
