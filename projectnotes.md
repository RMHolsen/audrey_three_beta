## To-Do
-- Add welcome path to new user creation with a set of instructions 
-- Remap projects-topics-lists associations with an eye to lists with multiple topics
-- Add delete methods to everything that needs them
-- Double checked logged_in? lock on edit and delete methods.

## Stretch Goals
-- Add boolean attribute to projects: active/inactive, give user the ability to toggle on and off
-- Add boolean attribute to lists: public/private, give user ability to toggle on and off
-- Add point of contact field to sources and 'notes' field for alerts about subscription drives, scholarships or sponsorships, etc.
-- Add 'edit password' function to editing a user profile, but with password confirmation and all those bells and whistles
-- Add boolean attribute to sources: online/offline. If offline, show the hours field and maybe an address field (add an address field)
-- Add genres field to Project form, show page, add genres field to User show page by iterating over project genres.
-- Add location and fee fields to Add a Source on item page? Or redirect if a source has been added to the sources page to suggest editing the source
This will require some considerable research into how to juggle all those params into a new thing. It shouldn't be too complex but try it anyway.
-- Change the topic assignment on list edit view to a radio button (adding on extra topics to a list isn't working right now, figure out that structure later)

## Plan 
A User has_many projects
A User has_many lists, through projects
A Project has_many lists, through topics
A List has_many projects, through topics
A Topic belongs_to a list and belongs_ to a project
An Item belongs_to a list and has_many attributes; items should be formulated to be as broad as possible: articles, films, tv episodes, vlogs, blogs, books, etc. 
A Source has_many Items
An ItemSource belongs_to an item and belongs_to a source.


DO NOT do anything with the public boolean just yet, eventually there will be a method that detects whether it's false or true and sets everything to visible or requires auth to see but right now just leave it at false and wait for the verification section before doing anything with it. 

## GITHUB

App ID: 116348

Client ID: Iv1.b02ea53854766c89

## Requirements
Use the Ruby on Rails framework. YES

-- Your models must:
    • Include at least one has_many, at least one belongs_to, and at least two has_many :through relationships (Items/Sources, Projects/Lists)
    • Include a many-to-many relationship implemented with has_many :through associations. The join table must include a user-submittable attribute — that is to say, some attribute other than its foreign keys that can be submitted by the app's user (Topics)
-- Your models must include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data. (username, item, maybe others for a project?)
-- You must include at least one class level ActiveRecord scope method. a. Your scope method must be chainable, meaning that you must use ActiveRecord Query methods within it (such as .where and .order) rather than native ruby methods (such as #find_all or #sort). (free/paywall)
-- Your application must provide standard user authentication, including signup, login, logout, and passwords. (Got it)
-- Your authentication system must also allow login from some other service. Facebook, Twitter, Foursquare, Github, etc... (**FUCKING OMNIAUTH**)
-- You must include and make use of a nested resource with the appropriate RESTful URLs.
    • You must include a nested new route with form that relates to the parent resource
    -- lists/list-id/items/id
    • You must include a nested index or show route
    -- lists/list-id/items?
-- Your forms should correctly display validation errors.
    a. Your fields should be enclosed within a fields_with_errors class
    b. Error messages describing the validation failures must be present within the view.
    -- Review this in guilds in beta
-- Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app.
    • Logic present in your controllers should be encapsulated as methods in your models.
    • Your views should use helper methods and partials when appropriate.
    • Follow patterns in the Rails Style Guide and the Ruby Style Guide.

## BUG HUNT
-- why the goddamn hell am I getting a leading "" in the topic_ids array when I make or edit a list? Does it have something to do with the way I used a collection_check_boxes object instead? What the fuck is going onnnnnn.
-- confirmation message for project delete method isn't working. keep googling.


## ROUTES 
So I don't have to keep doing rails routes rails routes rails routes
 Prefix Verb   URI Pattern                              Controller#Action
       projects GET    /projects(.:format)                      projects#index
                POST   /projects(.:format)                      projects#create
    new_project GET    /projects/new(.:format)                  projects#new
   edit_project GET    /projects/:id/edit(.:format)             projects#edit
        project GET    /projects/:id(.:format)                  projects#show
                PATCH  /projects/:id(.:format)                  projects#update
                PUT    /projects/:id(.:format)                  projects#update
                DELETE /projects/:id(.:format)                  projects#destroy
     list_items GET    /lists/:list_id/items(.:format)          items#index
                POST   /lists/:list_id/items(.:format)          items#create
  new_list_item GET    /lists/:list_id/items/new(.:format)      items#new
 edit_list_item GET    /lists/:list_id/items/:id/edit(.:format) items#edit
      list_item GET    /lists/:list_id/items/:id(.:format)      items#show
                PATCH  /lists/:list_id/items/:id(.:format)      items#update
                PUT    /lists/:list_id/items/:id(.:format)      items#update
                DELETE /lists/:list_id/items/:id(.:format)      items#destroy
          lists GET    /lists(.:format)                         lists#index
                POST   /lists(.:format)                         lists#create
       new_list GET    /lists/new(.:format)                     lists#new
      edit_list GET    /lists/:id/edit(.:format)                lists#edit
           list GET    /lists/:id(.:format)                     lists#show
                PATCH  /lists/:id(.:format)                     lists#update
                PUT    /lists/:id(.:format)                     lists#update
                DELETE /lists/:id(.:format)                     lists#destroy
         topics GET    /topics(.:format)                        topics#index
                POST   /topics(.:format)                        topics#create
      new_topic GET    /topics/new(.:format)                    topics#new
     edit_topic GET    /topics/:id/edit(.:format)               topics#edit
          topic GET    /topics/:id(.:format)                    topics#show
                PATCH  /topics/:id(.:format)                    topics#update
                PUT    /topics/:id(.:format)                    topics#update
                DELETE /topics/:id(.:format)                    topics#destroy
        sources GET    /sources(.:format)                       sources#index
                POST   /sources(.:format)                       sources#create
     new_source GET    /sources/new(.:format)                   sources#new
    edit_source GET    /sources/:id/edit(.:format)              sources#edit
         source GET    /sources/:id(.:format)                   sources#show
                PATCH  /sources/:id(.:format)                   sources#update
                PUT    /sources/:id(.:format)                   sources#update
                DELETE /sources/:id(.:format)                   sources#destroy
   free_sources GET    /sources/free(.:format)                  sources#free
paywall_sources GET    /sources/paywall(.:format)               sources#paywall
          users GET    /users(.:format)                         users#index
                POST   /users(.:format)                         users#create
       new_user GET    /users/new(.:format)                     users#new
      edit_user GET    /users/:id/edit(.:format)                users#edit
           user GET    /users/:id(.:format)                     users#show
                PATCH  /users/:id(.:format)                     users#update
                PUT    /users/:id(.:format)                     users#update
                DELETE /users/:id(.:format)                     users#destroy
         signup GET    /signup(.:format)                        users#new
                POST   /signup(.:format)                        users#create
          login GET    /login(.:format)                         sessions#new
                POST   /login(.:format)                         sessions#create
         logout GET    /logout(.:format)                        sessions#destroy
           root GET    /                                        static#index
