class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery
  before_filter :set_headers
  after_filter :set_csrf_cookie_for_ng
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def set_headers  
    if request.headers["HTTP_ORIGIN"]     
	  # better way check origin
	  # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
	  headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
	  headers['Access-Control-Expose-Headers'] = 'ETag'
	  headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
	  headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
	  headers['Access-Control-Max-Age'] = '86400'
	  headers['Access-Control-Allow-Credentials'] = 'true'
	end
  end   

  protected
    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
end