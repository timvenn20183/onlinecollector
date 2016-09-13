class DatafilesController < ApplicationController

    before_filter :check_site
    before_filter :must_be_logged_in

    def remove
        obj = current_site.datafiles.find_by_slug(params[:id]) if !params[:id].blank?
        return_path = '/item/' + obj.item.slug + '/edit'
        item = obj.item
        obj.destroy if !obj.blank?
        redirect_to return_path
    end

end
