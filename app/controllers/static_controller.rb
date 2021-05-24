class StaticController < ApplicationController

    def index
    end 
    
    def public_lists
        @lists = List.open.all 
    end 
end 