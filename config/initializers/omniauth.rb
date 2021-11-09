
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end

# Old and Busted
# Rails.application.config.middleware.use OmniAuth::Builder do 
  #  provider :github, Rails.application.credentials.github[:key], Rails.application.credentials.github[:secret]
# end 

