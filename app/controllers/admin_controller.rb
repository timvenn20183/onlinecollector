class AdminController < ApplicationController

    layout 'admin'

    before_filter :must_be_logged_in

    def index
    end

    def items
        @items = current_site.items
    end

    def fields
    end

    def profile
    end

end
