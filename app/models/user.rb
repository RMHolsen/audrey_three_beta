class User < ActiveRecord::Base 
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_secure_password
    has_many :projects 
    has_many :lists, through: :projects 

    def email_username
        self.email.split("@")[0]
        #Converts the user's email into a temporary? username, deal with the temporary bit later
        #This is mostly here in case someone wants to Omniauth in, in which case only an email and password would be given
        #This allows the app to take the username from the email and therefore make the user valid
        #MO MORE VALIDATION ERRORS FOR ME DAMMIT.
    end 

end 