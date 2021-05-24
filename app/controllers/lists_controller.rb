class ListsController < ApplicationController
    before_action :set_list, only: [:show, :edit, :update, :destroy]

    def index 
        @lists = []
        current_user.projects.each do |p|
            #Take the array of the current user's projects and iterate over each project
            p.lists.each do |l|
                #Take each project and iterate over the list
                @lists << l 
                #push each list to the array of lists 
            end 
        end 
    end 

    def show
        @items = @list.items 
        #For simpler iterating over in the view
        
    end 

    def new
        @list = List.new
        @topics = Topic.all 
        # Eventually this is going to have to be restricted by user, I think. That's going to be an entire day of work, ugh.
        # There should be a scope method here for topics without lists assigned but I couldn't make it work
    end 

    def create
        @list = List.new(list_params)
        @topic_ids = params[:list][:topic_ids]
        @topic_ids.shift
        #Why do I always have a blank one at the top
        #Find the chosen topics by the id in params
        if @list.valid? && @topic_ids != []
            @list.save
            #Save the list if the list is valid
            @topic_ids.each do |t|
                topic = Topic.find(t)
                topic.list = @list 
                topic.save 
            end 
            #Assign the list to each topic in the topic ids.
            redirect_to @list 
        else 
            redirect_to new_list_path
            #Otherwise do it again.
            #Tried doing this with a render method and it gave "undefined method `map' for nil:NilClass"
            #for line 7 of new.html.erb
            #Not sure what that means, may investigate further
            #Maybe also add an error message saying you need to pick a topic to add to a list.
        end 
    end 

    def edit
        @topics = Topic.all 
        #Again, to iterate over in the view, also going to need to be restricted by user.
    end 

    def update
        @topic_ids = params[:list][:topic_ids]
        @topic_ids.shift 
        #Same as the first, still have a blank in the topic ids, still don't know why
        if @list.update(list_params)
            @topic_ids.each do |t|
                 topic = Topic.find(t)
                 topic.list = @list 
                 topic.save 
            end 
            #If the list can update, redirect to the list page and add all the relevant topic ids to the list
            redirect_to @list 
        else 
            render :edit 
            #Otherwise do it all over again.
        end 
    end 

    def destroy
        @list.destroy
        redirect_to lists_path 
    end 

    private

    def set_list
        @list = List.find(params[:id])
    end 

    def list_params
        params.require(:list).permit(:name, topic_ids: [])
    end 

end 