class ImagefilesController < ApplicationController

    before_filter :check_site
    before_filter :must_be_logged_in

    def remove
        obj = current_site.imagefiles.find_by_slug(params[:id]) if !params[:id].blank?
        return_path = '/item/' + obj.item.slug + '/edit'
        item = obj.item
        obj.destroy if !obj.blank?
        item.check_default_image
        redirect_to return_path
    end

    def default
        obj = current_site.imagefiles.find_by_slug(params[:id]) if !params[:id].blank?
        if !obj.blank?
            item = obj.item
            item.prefs[:default_image] = obj.slug
            item.save
        end
        return_path = '/item/' + obj.item.slug + '/edit'
        redirect_to return_path
    end
end
