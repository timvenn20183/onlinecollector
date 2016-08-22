class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception


  def current_site
    return Site.first if Site.count == 1
    return Site.find_by_subcode(request.subdomain.split(".").first)
  end

end
