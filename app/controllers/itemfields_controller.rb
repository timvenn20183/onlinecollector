class ItemfieldsController < ApplicationController

    def index
        @itemfields = current_site.itemfields
    end

    def show
        @itemfield = current_site.itemfields.find_by_slug(params[:id])
    end

end
