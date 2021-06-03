Rails.application.config.middleware.use Omniauth::Builder do 
    provider :github, Rails.application.credentials.github[:key], Rails.application.credentials.github[:secret]
end 