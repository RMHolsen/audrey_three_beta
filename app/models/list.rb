class List < ActiveRecord::Base 
    validates :name, presence: true 
    
    has_many :items 
    has_many :topics 
    has_many :projects, through: :topics 

    scope :open, -> {where(public: true)}

    def list_with_projects
    #Create a list of projects associated with a given wish list 
        projects = []
        #Set projects as an empty array to be filled with...
        self.projects.each do |p|
            projects << p.name 
            #... the name of each project associated with the list self object thing
        end 
        projects.join(", ")
        #Join the array into a string separated by comma-space.
    end 
end 