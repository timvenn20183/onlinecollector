class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    helper_method :current_site

    def current_site
       	return Site.find_by_subdomain(request.subdomain.split(".").first)
    end

    def set_session(user)
        session[:user] = user.appkey
    end

    def del_session
        session[:user] = nil
    end

    def is_logged_in
        return true if session[:user] != nil and current_site.users.map(&:appkey).include?(session[:user])
        return false
    end

    def must_be_logged_in
        if !is_logged_in then
            redirect_to '/'
        end
    end

    def check_site
        redirect_to '/' if current_site == nil
    end

end
