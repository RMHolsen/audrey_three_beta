class ItemSource < ActiveRecord::Base 
    belongs_to :item 
    belongs_to :source 
end 