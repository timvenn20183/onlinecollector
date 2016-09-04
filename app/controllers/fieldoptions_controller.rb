class FieldoptionsController < ApplicationController

    def index
        @fieldoptions = current_site.fieldoptions
    end

    def show
        @fieldoption = current_site.fieldoptions.find_by_slug(params[:id])
    end

end
