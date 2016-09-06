class ItemsController < ApplicationController

    before_filter :check_site
    before_filter :must_be_logged_in, :only => [:new, :edit, :create, :update]

    def index
        fieldoption = params[:fieldoption]
        itemfield = params[:itemfield]
        @items = current_site.fieldoptions.find_by_slug(fieldoption).items if fieldoption != nil
        @items = current_site.itemfields.find_by_slug(itemfield).items if itemfield != nil
        @items = current_site.items if fieldoption == nil and itemfield == nil
    end

    def show
        @item = current_site.items.find_by_slug(params[:slug])
    end

    def new
        @item = Item.new
        @item.site = current_site
    end

    def create
        @item = Item.new
        if @item.update_attributes(item_params)
            render :text => @item.inspect
        else
            render :text => @item.errors.inspect
        end
    end

    def edit
        @item = current_site.items.find_by_slug(params[:slug])
    end

    def update
        @item = Item.find_by_id(decrypt(params[:id]))
        @item.update_attributes(item_params)
        options = []
        params[:fields].each_pair do |key,value|
            options << Itemfield.find(decrypt(key)).update_fieldoptions_from_string(value) if !key.blank?
        end
        @item.fieldoptions = options.flatten
        render action: :edit
    end

    private

    def item_params
        params.require(:item).permit(:name, :note, :collectionid, :site_id)
    end

end
