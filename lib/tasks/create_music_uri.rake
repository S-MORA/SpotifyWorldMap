task music_uri: :environment do
  RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  spotify = RSpotify::User.find('thesoundsofspotify')
  genres = Genre.all
  countries = Country.all
  create_all_playlists(spotify)

  genres.each do |genre|
      check_playlists(genre)
  end

  countries.each do |country|
    check_playlists(country)
  end
end

def create_all_playlists(user)
  @playlists = []
  offset = 0
  while offset < 7101
    @playlists += user.playlists(limit: 50, offset: offset)
    offset += 50
  end
end


def check_playlists(type)
  @playlists.each do |playlist|
    if I18n.transliterate(playlist.name.downcase.strip) == "the sound of #{type.name.downcase.strip}" || I18n.transliterate(playlist.name.strip) == "The Sound of #{type.name.titleize.strip}" || I18n.transliterate(playlist.name.downcase.strip) == "the sound of the #{type.name.downcase.strip}"
      type.uri = playlist.uri
      type.save
      break
    end
  end

end
