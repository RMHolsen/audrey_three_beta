class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    
    # def index
    #     Leaving this here just in case, but there doesn't really seem to be a need for an items index right now.
    #     @items = Item.all 
    # end 

    def show 
        @sources = @item.sources 
        #Assigns a variable to all the item's sources so they can be shown on the item page.
    end 

    def new
        @item = Item.new 
        @list = List.find(params[:list_id])
        #A new item for the form_for object, and since it's a nested thing find the list based on the params given
    end 

    def create
        @list = List.find(params[:list_id])
        @item = Item.new(item_params)
        #Find the list and instantiate the new item
        # if params[:vet_id] && @vet = Vet.find(params[:vet_id]) meaning, if there is a params indicating a nested route and 
        # I can set that params equal to an instance
        #     @pet = @vet.pets.build 
        #     else 
        #     @pet = Pet.new
        #     end 
        if @item.valid?
            #Check the item's validity, we need at least a name and a type of material so we know what we're looking for
            @item = @list.items.build(item_params)
            @item.save 
            #Build the item and save the item
            redirect_to @list
            #Redirect to the full list
        else
            render :new
            #Or else do it all over again
        end 
    end 

    def edit
        @item = Item.find(params[:id]) 
        @list = List.find(params[:list_id])
        # Can't remember why the lists variable was here. Is this an artifact? 
        @lists = List.all 
    end 

    def update
        #Wait. We don't need an item set because we have one in the before_action
        @list = List.find(params[:list_id])
        #We do however need a list set the way the form is built. I think. 
        if @item.update(item_params)
            redirect_to list_item_path(@list, @item)
            #If the item is valid, the update function should clear and then the user is redirected to the item page
        else 
            render :edit 
            #Otherwise do it all over again
        end 
    end 

    def destroy
        @list = @item.list 
        @item.destroy 
        redirect_to @list 
    end 

    private

    def set_item
        @item = Item.find(params[:id])
        #before actions that build off of a dynamic route, find the item by id
    end 

    def item_params
        params.require(:item).permit(:name, :material, :creator, :publication_date, :list_id, source_ids:[], sources_attributes: [:name])
        #The sources attributes must be for adding a new source by name
        #In which case maybe if you add a new source by name redirect to that new source's edit page to fill out the junk for it.
    end 

    def list_params
        params.require(:list).permit(:name)
    end 
end 