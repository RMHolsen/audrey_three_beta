class SourcesController < ApplicationController 
before_action :set_source, only: [:show, :edit, :update]

    def index
        @sources = Source.all.sort { |a, b| a.name <=> b.name }
        #All sources sorted in alphabetical order by name of source
    end 

    def show 
    end 

    def new
        @source = Source.new
    end 

    def create
        @source = Source.new(source_params)
        if @source.valid? 
            @source.save 
            redirect_to @source 
        else 
            render :new
        end 
    end 

    def edit
    end 

    def update
        if @source.update(source_params)
            redirect_to @source
        else 
            render :edit 
        end 
    end 

    def free 
        @sources = Source.free.sort { |a, b| a.name <=> b.name }
        #Free sources by alphabetical order, class method in model
    end 

    def paywall
        @sources = Source.paywall.sort { |a, b| a.name <=> b.name }
        #Paywalled sources by alphabetical order, class method in model
    end 

    #def destroy
    #end 

    private

    def set_source 
        @source = Source.find(params[:id])
    end 

    def source_params
        params.require(:source).permit(:name, :location, :contact, :fee, :hours, :description)
    end 
end 