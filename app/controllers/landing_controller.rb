class LandingController < ApplicationController
  before_action :authenicate_spotify

  def authenicate_spotify
   RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  end

  def index
   playlist = RSpotify::Playlist.find('thesoundsofspotify', '7uqYdS5eDfOwIsYEEFqeng')
   @URI = playlist.uri
  end

  def country
    country = Country.find_by('name': params[:country])
    if country.present?
      uri = "https://open.spotify.com/embed?uri=#{country.uri}"
      render json: {success: true, uri: uri}
    else
      render json: {success: false, message: "There is not enough data on this country"}
    end
  end

  def country_genres
    country = params[:country]
    @countrygenres = Country.find_by('name': country).genres.order(id: :asc)
    render json: @countrygenres
  end

  def play_genre
    genre = Genre.find_by('name': params[:genre])
    uri = "https://open.spotify.com/embed?uri=#{genre.uri}"
    render json: {uri: uri}
  end

  def search
    search = params[:search]
    country = Country.where("lower(name) LIKE ?", search.downcase)
    if country.present?
      uri = "https://open.spotify.com/embed?uri=#{country.first.uri}"

      render json: {success: true, uri: uri, genres: country.first.genres.reverse}
    else
      render json: {success: false, message: "There is no data on this country, try again."}
    end
   end

end
