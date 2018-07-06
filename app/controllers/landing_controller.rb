class LandingController < ApplicationController
  before_action :authenicate_spotify

  def authenicate_spotify
   RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  end

  def index
   playlist = RSpotify::Playlist.find('thesoundsofspotify', '69fEt9DN5r4JQATi52sRtq')
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
    render json: @countrygenres.reverse
  end

  def play_genre
    genre = Genre.find_by('name': params[:genre])
    @URI = "https://open.spotify.com/embed?uri=#{genre.uri}"
    render json: {uri: @URI}
  end


end
