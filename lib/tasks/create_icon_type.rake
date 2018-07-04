task icon_type: :environment do
  genres = Genre.all
  genres.each do |genre|
    words = genre.name.split(/[ -]+/)
      words.each do |word|
      if word == "electronic" || word == "chill" || word == "wave" || word == "techno" || word == "house"
       iconType = "record"
      elsif word == "hop" || word == "r&b" || word == "trap" || word == "reggaeton"
       iconType = "hip-hop"
      elsif word == "pop"
        iconType = "pop"
      elsif word == "metal" || word == "screamo"
        iconType = "metal"
      elsif word == "singer" || word == "rap" || word == "soul" || word == "gospel"
        iconType = "sing"
      elsif word == "rock"
        iconType = "rock"
      elsif word == "indie" || word == "country"
        iconType = "indie"
      elsif word == "jazz" || word == "funk"
        iconType = "jazz"
      else
      iconType = "gen"
     end
     genre.icon = iconType
     genre.save
    end
  end
end
