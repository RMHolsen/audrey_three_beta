class CreateSources < ActiveRecord::Migration 
    def change 
        create_table :sources do |t|
            t.string :name 
            t.string :location 
            t.string :contact 
            t.string :hours 
            t.text :description 
            t.boolean :fee, default: true 
        end 
    end 
end 
