class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :username
            t.string :display_name 
            t.string :email
            t.string :profile 
            t.string :password_digest
        end 
    end 
end 