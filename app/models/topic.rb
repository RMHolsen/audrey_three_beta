class Topic < ActiveRecord::Base 
    belongs_to :project 
    belongs_to :list 

     def test_name 
         self.name 
     end 
    # Leaving this in here as sort of a demonstration, this was a test to see if I could create the name_with_project method.

    def name_with_project 
        if !!self.project 
            "#{self.name} - #{self.project.name}"
        else
            "#{self.name} - (unassigned)" 
        end 
    end 

    scope :naked, -> {where(list_id: nil)}
    #Maybe an artifact method, trying to sort out only the topics where they don't have a list id attached

end 