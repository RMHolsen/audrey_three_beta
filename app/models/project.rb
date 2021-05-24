class Project < ActiveRecord::Base 
    validates :name, presence: true 
    
    has_many :topics
    has_many :lists, through: :topics 
    
    belongs_to :user 
end 