class CreateProjects < ActiveRecord::Migration 
    def change 
        create_table :projects do |t|
            t.string :name 
            t.string :description 
            t.text :summary
            t.string :genre 
            t.integer :user_id 
            t.timestamps null: false 
        end 
    end 
end 