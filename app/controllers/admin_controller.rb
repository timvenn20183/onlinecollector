class AdminController < ApplicationController

    layout 'admin'

    before_filter :must_be_logged_in

    def index
    end

    def items
        @alphabet_letters = current_site.items.map(&:alphabet_letter).uniq.sort
        if !params[:search].blank?
            @items = current_site.items.where("searchstring like ?","%#{params[:search]}%").paginate(page: params[:page], per_page: 20)
        else
            @items = current_site.items.paginate(page: params[:page], per_page: 20) if @items.blank?
        end
        if !params[:alphabet_search].blank?
            @items = current_site.items.where('alphabet_letter = ?', params[:search].upcase).paginate(page: params[:page], per_page: 20)
        end
        @items = current_site.items.paginate(page: params[:page], per_page: 20) if !params[:alphabet_search].blank? and params[:search] == 'all'
    end

    def fields
    end

    def profile
    end

end
