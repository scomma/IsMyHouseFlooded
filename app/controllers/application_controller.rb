class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def authenticate_admin!
      authenticate_or_request_with_http_basic do |username, password|
        username == "noah" and
        password == "lactobacillus"
      end
    end

    def current_user
    end
end
