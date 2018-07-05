task music_uri: :environment do
  RSpotify.authenticate("722c32a9059e4ae8884bf2aad1838e1a", ENV['SPOTIFY_SECRET_ID'])
  spotify = RSpotify::User.find('thesoundsofspotify');
  genres = Genre.all

  create_all_playlists(spotify)

  genres.each do |genre|
    offset = 0;
    check_playlists(genre)
  end

  countries = Country.all

  countries.each do |country|
    offset = 0;
    check_playlists(country)
  end

end

def create_all_playlists(user)
  @playlists = []
  offset = 0
  while offset < 7101
    print "making request for offset #{offset}"
    @playlists += user.playlists(limit: 50, offset: offset)
    offset += 50
  end
end


def check_playlists(type)
  print "array length: #{@playlists.length}"
  @playlists.each do |playlist|
    if playlist.name.downcase.strip == "the sound of #{type.name.downcase.strip}" || playlist.name.strip == "The Sound of #{type.name.titleize.strip}" || playlist.name.downcase.strip == "the sound of the #{type.name.downcase.strip}"
      type.uri = playlist.uri
      type.save
      break
    end
  end
end
