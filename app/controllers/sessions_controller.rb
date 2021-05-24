class SessionsController < ApplicationController

    def new 
        @user = User.new 
        render :login 
    #     #Start a new user object, render the session view 'login'
    #     #Wait, starting a new user object should be in the users controller. Shouldn't it?
    #     #Maybe not, since we need to render the view... ugh, I'm confused.
    end 

    def create
        #if auth_hash == request.env["omniauth.auth"]
        #Then we know they are logging in via OAuth
        #oauth_email = request.env["omniauth.auth"]["info"]["email"]
        #Grab the email from the authorization hash

            #if user = User.find_by(email: oauth_email) (username: params[:user][:email])
                #session[:user_id] = user.id
            #else 
                #user = User.create(email: oauth_email, password: SecureRandom.hex)
                #session[:user_id] = user.id
            #end 
        
        #else
        #normal login flow

            @user = User.find_by(username: params[:user][:username])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id 
                redirect_to @user 
            else 
                redirect_to root
                #Redirecting is acceptable here for security protocol purposes
                #Flash error message goes here
            end 

        #end
    end 

    def destroy
        session.clear
        redirect_to root_path
    end 

    private 

end 