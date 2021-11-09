class SessionsController < ApplicationController


    def new 
        @user = User.new 
        render :login 
    end 
    # Not sure I need this but it's staying there till I know if I do or not
    # YES YOU DO LEAVE IT IN
    # COULD USE SOME REFACTORING 


    def create
        if auth 
        # If there's an auth hash it's an omniauth login
            @user = User.find_by(email: auth['info']['email'])
            # Have to use this instead of user do block
            if !@user
                # If there is no user by that email, make a user
                @user = User.new 
                @user.email = auth['info']['email']
                @user.username = @user.email_username
                @user.password = SecureRandom.hex(12)
                @user.save 
                # Slightly complicated getting around validations requiring a username here
                # Could use some refactoring
                session[:user_id] = @user.id 
                redirect_to @user 
            elsif @user 
                # Or if there is a user, generate the user
                session[:user_id] = @user.id 
                @user.password = SecureRandom.hex(12)
                redirect_to @user 
            else 
                redirect_to root_path 
                # Error messages about Github's email settings go here.
            end 
        else 
        # Use the regular login type thing. 
            @user = User.find_by(username: params[:user][:username])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id 
                redirect_to @user 
            else 
                redirect_to root_path 
                # Redirecting is acceptable here for security protocol purposes
                # Flash error message goes here
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