class LandingController < ApplicationController
  before_action :authenicate_spotify

  def authenicate_spotify
   RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  end

  def index
   playlist =  RSpotify::Playlist.search("The Sound Of Chicago Soul").first
   @URI = playlist.uri
  end

  def country
    country = Country.find_by('name': params[:country])
    @URI = "https://open.spotify.com/embed?uri=#{country.uri}"
    render json: {uri: @URI}
  end

  def country_genres
    country = params[:country]
    @countrygenres = Country.find_by('name': country).genres
    render json: @countrygenres
  end

  def play_genre
    genre = params[:genre]
    playlist =  RSpotify::Playlist.search("The Sound of #{genre}").first
    @URI = "https://open.spotify.com/embed?uri=#{playlist.uri}"
    render json: {uri: @URI}
  end


end
