## 22 February 2021
Started repository
Noted associations, created sections in dev log for bug hunt, requirements, etc. 

## 23 February 2021
Added license
Added an assload of migrations and some notes to the project about labs to look at and scope to work on right now, vs things included in the migration for future development.
Added routes, tentatively, including nested routes
Added css and minor styling to application layout, added a static controller for the index page and in case of further need for static pages, maybe one on sources, maybe one with citation formatting, IDK.
Added some rspec tests on account of the damn local server not working, stubbed out projects controller and project views 
Filled out the Readme. 

## 24 February 2021
Added basic controllers for all models. 
Topped off basic views with partial for Projects

## 25 February 2021
Added user/sessions controller and views, user migration, user model, partially coded each
(Go over this to make sure all the code works, you were definitely not awake)

## 26 February 2021
Adding List and Item controllers, views, relationships, tweaking routes a bit.

## 3 March 2021
Built List and Item views
Added destroy method to Projects, Lists, Items controllers
Built tests for List and Item views, passed tests

## 4 March 2021
Built Add Topic form as a partial, added to Project show view
Built topic display method on Project show view, added if function to show links to the lists if they exist and "add a list for this topic" if they don't.
Built tests for Project show view 

## 5 March 2021
Went over Items, Lists controllers
Cleaned up Item, List models
Added name_with_project method to Topic model
Cleaned up Items, Lists views
Cleaned up Project view and controller
Wrote tests for Items, Lists, and Projects
Went over app flow
Began writing Sources views, added a couple routes for paid/free specific Source index views
Wrote a couple tests for Sources to make sure the check box/boolean process worked as advertised (it does)

## 9 March 2021
Added validations to User model no clue what I was thinking
Added outline of omniauth method. Yuck. Omniauth. 

## 23 March 2021
Added destroy methods for Items, Topics
Added scope methods for Sources
Reviewed code
Bug Hunted the Log In page

## May 13 2021
Started making it. Had a breakdown. Bon Appetit.

Reworked the project creation page to require sign in so there aren't loose projects floating around
Bug Hunted the Sign Up page
Bug Hunted the User Profile page
Added 'genres' field to Project
Added 'display_name' field to User
Added 'View my Profile' to User Profile page
Enacted functionality to Log Out button
Added 'Delete' button and functionality to Project page. 
Restricted 'Edit' and 'Delete' button, 'Add a Topic' button on Project page to Project user (TEST THIS)
Added user_id to Projects schema. We will not discuss how I missed this. 
Unexpected debug for topics without projects. 

## May 14 2021
Edited create method for Project to attach it to the current user creating the project
Edited delete method for Project to delete all associated topics, since topics are more directly related to projects than lists
Created a page for public lists, had to do it off the static page, maybe look into why and how to make it a little easier? If there is a way.
Created a page (lists_index) for the user's lists only, both public and private.

## MAY 17 2021
Started a cleanup tag for future reference 
Updated List creation to require that the list also be assigned to a Topic, so it has a Project, so it has a User.
Due to Bugs (see project notes: bug hunt) and general design paradigm, new source page relocated to its own publicly available page.
Checked functionality of Source show, new, and edit pages; all good. (New fields to be added)

## May 18 2021
Added hours and description field to Source page, added a stretch goal for an address field
Checked functionality of Source index, paywall, and free pages, all good.
Added sort method to Source page, free and paywall pages to sort by alphabetical order.
Changed Topic display format from Topic name - List name to Topic Name - Wish List/Create a Wish List for clarity
Removed artifact "Genres" from User show page 
Cosmetic cleanup on User show page and User and Project edit pages
Cosmetic cleanup on Item form page to indicate what list the item is going onto. Just for clarity's sake.
Debugged the Edit an Item link/page/path, etc. 
Checked functionality of source pick checkbox method
Added 'Add a Source' field
Debugged 'Add a Source' field. Next time check your validations before you go unwriting and rewriting your code five times trying to figure out why it won't create the new object.

## May 20 2021
Tried Omniauth.  Had a breakdown. Bon Appetit.
(Actually, nothing to do with this app directly but I did figure out how to get around the Rails version error that 
kept kicking up when I tried to create a new app, so the original Audrey Three repo may get frozen here and a new one started.
Or I may start up a new folder locally and overwrite the github repo. Debate debate. Hm.)

## May 21 2021
I am screaming inside my heart
Accidentally? deleted? bin file? copied over bin file
Kept running into errors trying to run rails commands.
Commented out 'load defaults' from config/application.rb
Commented out 'config.active_storage.service = :local' from config/environments/development.rb
Installed 'mini-magic' in Gemfile, no real result there but also no further errors.
Commented out 'config.active_record.verbose_query_logs = true' from config/environments/development.rb
Found the bin file! It was in the stupid db folder. Replaced bin file with original app bin file. 
(So, in the future, in order to create a rails app in this rails version, the answer is comment out the above three things and then start running crap.)

## May 24 2021
Added errors fields w/customized styling
Cosmetic edits to Item new, show views, User show view, Lists index, show view
Locked edit profile button behind logged_in? conditional
Attempted to limit topics field on List new/edit views to open topics only, failed

## 9 June 2021
ON CLEAN BRANCH
Went through an hour or so of debugging omniauth with Dustin and Jessica; got Omniauth mostly probably working: 
BUG NOTES: First, need: <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %> to make sure Omniauth gems can direct everything to the right path. Then, app/assets/javascripts/application.js deleted //= require activestorage to remove gem incompatibilities, then updated the Gemfile to: 

gem 'omniauth', '1.9.1'
gem 'omniauth-github'
gem 'dotenv-rails'
and commented out gem 'omniauth-rails_csrf_protection'

Gemfile lock should appear
oauth2 (1.4.7)
      faraday (>= 0.8, < 2.0)
      jwt (>= 1.0, < 3.0)
      multi_json (~> 1.3)
      multi_xml (~> 0.5)
      rack (>= 1.2, < 3)
    omniauth (1.9.1)
      hashie (>= 3.4.6)
      rack (>= 1.6.2, < 3)
    omniauth-github (1.4.0)
      omniauth (~> 1.5)
      omniauth-oauth2 (>= 1.4.0, < 2.0)
    omniauth-oauth2 (1.7.1)
      oauth2 (~> 1.4)
      omniauth (>= 1.9, < 3)
      
Debugged Login via Omniauth path a bit

## 10 June 2021
Restructured the logic path for Omniauth login to create a user if user not found, 
  with a username based on the email_username method
Debugged the profile page (somehow the erb if structure doesn't accept 
  "if @variable" or "if !!@variable")
Debugged the login method (it's redirect_to root_path, not redirect_to root)

## 17 June 2021
Few last little improvements/bugs discovered: added link to source show page from 
  source index per source
Fixed display_name/username bug on User show page by adding a helper method

## 9 November 2021
Merged clean-branch-for-omniauth with main, keeping clean-branch... for future safety against bugs purposes
Filled out ReadMe

## 28 December 2021
After some intermittent frustration at the Erubi bug still happening... fixed the bug on main. (See project notes)
Also cleared another minor bug about not finding user.id=1; turns out you really do need to type "rails db:migrate RAILS_ENV=development" and not "rails db:migrate"
Will study further the difference between the two.

## 9 January 2022
Set up the route for a welcome info page (static/info.html.erb)
Set up redirect in Users Conteroller for welcome info page
Did not write the welcome info page, that's for when I'm not down with a virus
Did not test the welcome info page, that's for... etc. But this is a simple thing on the to-do list I can clear now.

## 23 January 2022
Wrote some copy for the welcome info page
