Rails.application.routes.draw do
  get '/', to: 'landing#index'
  get '/country', to: 'landing#country'
  get '/genres', to: 'landing#country_genres'
  get '/play-genre', to: 'landing#play_genre'
end
