Rails.application.routes.draw do
  get '/', to: 'landing#index'
  get '/country', to: 'landing#country'
end
