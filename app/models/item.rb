class Item < ActiveRecord::Base 
    validates :name, :material, presence: true 
    #Must have a name and material so we know what we're looking for if we need to Google.

    belongs_to :list 
    has_many :item_sources
    has_many :sources, through: :item_sources 
    #Item belongs on a list, only one list per item to keep things simpler
    #Item can have many sources, though, because you can read a book digitally or via physical movie, or listen to it, etc.
    #You can download a movie from streaming or purchase it on DVD or... etc.

    def sources_attributes=(source_attributes)
        source_attributes.values.each do |source_att|
        #Take the value of the source_attributes part of the hash in item params and iterate over its values (just the one)
            if source_att.present?
              new_source = Source.find_or_create_by(source_att)
              #Assign a variable name and find or create the source by name, that being the source attribute
              self.item_sources.build(source: new_source)
              #Add in the source to the join table for items to sources
            end
        end
    end

end 