class Source < ActiveRecord::Base 
    validates :name, presence: true 
    #validates :fee, not sure how to do boolean validations 
    #remember you had the location validation thing here and that fucked you up.
    
    has_many :item_sources 
    has_many :items, through: :item_sources 

    scope :free, -> {where(fee: false)}
    scope :paywall, -> {where(fee: true)}
    
    #scope :order_by_age, -> {order(:age)}
    #scope :older_animals, -> {where("age > ?", 7)}
    #scope :dogs, -> {where(species: "Dog")}
    #scope :cats, -> {where(species: "Cat")}
    #scope :fish, -> {where(species: "Fish")}

    #scope :search_by_age, -> (search_age){where("age = ?", search_age)}

    #in controller: @pets = Pet.search_by_age(params[:age]).order_by_age 
end 