class TopicsController < ApplicationController
    before_action :set_topic, only: [:show, :edit, :update, :destroy]

    def index
        @topics = Topic.all 
    end 

    def show
    end 

    def new 
        @topic = Topic.new
    end 

    def create
        @topic = Topic.new(topic_params)
        if @topic.valid? 
            @topic.save 
            redirect_to project_path(@topic.project)
        else 
            render :"projects/new"
        end 
    end 

    def edit
    end 

    def update
        if @topic.update(topic_params)
            redirect_to @topic 
        else 
            render :edit 
        end 
    end 

    def destroy
        @project = @topic.project 
        @topic.destroy
        redirect_to @project 
    end 

    private

    def set_topic 
        @topic = Topic.find(params[:id])
    end 

    def topic_params
        params.require(:topic).permit(:name, :project_id, :list_id)
    end 
end 
