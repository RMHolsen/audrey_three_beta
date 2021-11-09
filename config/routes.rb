Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :projects #do 
# Originally intended to have lists nested under projects but maybe it makes more sense to have items nested under lists
# Since lists may be useful across more than one project, and eventually there will be a public/private toggle

resources :lists do 
  resources :items 
end 
# Either way it definitely makes sense to have items nested under lists. 

resources :topics   
# Topics as join table, largely private to individuals except through public lists, containing project information

resources :sources 
# Sources being an independent object rather than a subset of items, because an item can have many different sources
# And sources can have many different items. 

get '/free_sources', to: 'sources#free', as: "free_sources"
get '/paywall_sources', to: "sources#paywall", as: "paywall_sources"

# Sources are always public regardless of the list they're connected to through items, and people can view by paid or free

resources :users
get '/signup', to: 'users#new'
post '/signup', to: 'users#create'
# Creating new users

#resources :sessions? 
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
get '/logout', to: 'sessions#destroy'
# Creating and destroying sessions

root 'static#index'
get '/public_lists', to: 'static#public_lists', as: "public_lists"
# Preliminary landing page for public lists

#Omniauth Github
get '/auth/github/callback', to: "sessions#create"
#Once github authenticates the user this is where we want the user to land, at creating a new session
end
