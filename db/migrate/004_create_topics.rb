class CreateTopics < ActiveRecord::Migration 
    def change 
        create_table :topics do |t|
            t.string :name 
            t.belongs_to :project 
            t.belongs_to :list 
        end 
    end 
end 