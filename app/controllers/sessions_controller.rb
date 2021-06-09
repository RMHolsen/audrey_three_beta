class SessionsController < ApplicationController

    # def new 
    #     @user = User.new 
    #     render :login 
    # end 
    # Not sure I need this but it's staying there till I know if I do or not

    # COULD USE SOME REFACTORING 

    def create
        if auth 
        # If there's an auth hash it's an omniauth login
            @user = User.find_by(email: auth['info']['email']) do |u|
                u.password = SecureRandom.hex(12)
            end     
            if @user 
                @user.email = auth['info']['email']
                @user.username = @user.email_username
                @user.save 
                # Slightly complicated getting around validations requiring a username here
                session[:user_id] = @user.id 
                redirect_to @user 
            else 
                redirect_to root_path
            end 
        else 
        # Use the regular login type thing. 
            @user = User.find_by(username: params[:user][:username])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id 
                redirect_to @user 
            else 
                redirect_to root
                #Redirecting is acceptable here for security protocol purposes
                #Flash error message goes here
            end 
        end 
    end 

    def destroy
        session.clear
        redirect_to root_path
    end 

    private 

    def auth 
        request.env["omniauth.auth"]
        # Returns a hash of omniauth data
    end 
end 