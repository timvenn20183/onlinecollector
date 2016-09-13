class ItemsController < ApplicationController

    before_filter :check_site
    before_filter :must_be_logged_in, :only => [:new, :edit, :create, :update]

    layout 'admin', only: [:new, :create, :edit, :update]

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
        @item = Item.new(item_params)
        @item.site = current_site
        if @item.save
            options = []
            params[:fields].each_pair do |key,value|
                options << Itemfield.find(decrypt(key)).update_fieldoptions_from_string(value) if !key.blank?
            end
            @item.fieldoptions = options.flatten
            if !params[:newupload].blank?
                @image = Imagefile.new(name: @item.name, site: current_site, item: @item, image: params[:newupload])
                @image.save
            end
            if !params[:newdatafile].blank?
                @datafile = Datafile.new(name: @item.name, site: current_site, item: @item, data: params[:newdatafile])
                @datafile.save
            end
            redirect_to '/admin/items'
            return
        else
            render action: :new
            return
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
        Imagefile.new_image(@item, params[:newupload])
        Imagefile.update_details(current_site,params[:imagefile])
        Datafile.new_datafile(@item, params[:newdatafile])
        Datafile.update_details(current_site,params[:datafile])

        redirect_to '/item/' + @item.slug + '/edit'
    end

    def remove
        item = current_site.items.find_by_slug(params[:slug])
        item.imagefiles.each do |i|
            i.destroy
        end
        item.datafiles.each do |d|
            d.destroy
        end
        item.destroy
        redirect_to '/admin/items'
    end

    private

    def item_params
        params.require(:item).permit(:name, :note, :collectionid, :site_id, :acquired_date)
    end

end
