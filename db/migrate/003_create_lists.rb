class CreateLists < ActiveRecord::Migration 
    def change 
        create_table :lists do |t|
            t.string :name 
            t.boolean :public, default: false 
            t.timestamps null: false 
        end 
    end 
end 