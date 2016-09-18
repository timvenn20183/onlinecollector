class SiteController < ApplicationController

    layout :select_layout

    before_filter :check_site, :except => [:signup, :signup_process, :signin, :signin_process, :index, :terms, :about]

    def index
        if current_site == nil then
            render 'main/index'
            return
        end
    end

    def signup
        render 'site/signup', locals: {site: Site.new, user: User.new}
    end

    def signup_process
        @user = User.new
        @user.email = params[:email]
        @user.password = encrypt(params[:password])
        @site = Site.new
        @site.subdomain = params[:subdomain]

        if (params[:password] != params[:confirm]) or (params[:password].blank?) then
            @user.errors.add(:password, I18n.t('user.validation.password_not_match'))
            render template: 'site/signup', locals: {site: @site , user: @user}
            return
        end

        if !@user.save then
            render template: 'site/signup', locals: {site: @site , user: @user}
            return
        end
        if !@site.save then
            @user.destroy
            render template: 'site/signup', locals: {site: @site , user: @user}
            return
        else
            @site.users << @user
            SiteMailer.activation(@site).deliver_now
        end
    end

    def signin
        if current_site == nil then
            render 'main/index'
            return
        else
            render template: 'site/signin', locals: {error: nil}
            return
        end
    end

    def signout
            del_session
            redirect_to '/'
    end

    def signin_process
        email = params[:email]
        password = encrypt(params[:password])
        user = User.where(email: email, site_id: current_site.id).first
        if user == nil then
            render template: 'site/signin', locals: {error: I18n.t('forms.signin.error')}
            return
        elsif decrypt(user.password) != decrypt(password)
            render template: 'site/signin', locals: {error: I18n.t('forms.signin.error')}
            return
        else
            set_session(user)
        end
        redirect_to '/'
    end

    def terms
    end

    def about
    end

    private

    def select_layout
        return 'main' if current_site == nil
    end

end
