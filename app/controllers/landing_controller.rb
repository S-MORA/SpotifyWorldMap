class LandingController < ApplicationController
  before_action :authenicate_spotify

  def authenicate_spotify
   RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  end

  def index
   playlist = RSpotify::Playlist.find('wizzler', '00wHcTN0zQiun4xri9pmvX')
   @URI = playlist.uri
  end

  def country
    country = params[:country]
    playlist =  RSpotify::Playlist.search("The Sound Of #{country}").first
    @URI = "https://open.spotify.com/embed?uri=#{playlist.uri}"
    render json: {uri: @URI}
  end


end
