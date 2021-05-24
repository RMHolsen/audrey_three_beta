class ProjectsController < ApplicationController 
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
        if logged_in?
            @projects = current_user.projects.all
        end  
        #Show the array of all the projects for the current user if a user is logged in
    end 

    def show
        @topic = Topic.new 
        #Shows the project with the option of creating a new topic for the project
    end 

    def new
        if logged_in? 
        #If there is a user logged in, render the new project form
            @project = Project.new 
        else 
            redirect_to root_path
        end 
        #New project form
    end 

    def create
        @project = Project.new(project_params)
        #Create a new project using the fed params
        @user = current_user 
        #Assign the user to a variable using the helper method current_user
        if @project.valid? 
            @project.user = @user 
            @project.save 
            #This should be able to be refactored slightly to @user.project.build? look into it
            redirect_to project_path(@project)
            #If the project is valid according to all validations in the model, save the project
            #Redirect to show the project
        else 
            render :new 
            #Or else render the new page again, which will autofill everything already entered
        end 
    end 

    def edit
    end 

    def update
        if @project.update(project_params)
            #If the project params update properly with validations from the model
            redirect_to project_path(@project)
            #Show the updated project
        else 
            render :edit 
            #Or else render the edit page again, for reasons above
        end 
    end 

    def destroy
         Topic.all.each do |t|
            if t.project_id == @project.id 
               t.destroy
            end 
            #Could this be a ternary operator?
         end 
         #Filter through all the topics and delete all the ones pertaining to the project to be deleted
         @project.destroy 
         #Then delete the project
         redirect_to projects_path
    end 

    private

    def project_params
        params.require(:project).permit(:name, :description, :summary, :genre, :created_at, :updated_at)
    end 

    def set_project 
        @project = Project.find(params[:id])
    end 
end 