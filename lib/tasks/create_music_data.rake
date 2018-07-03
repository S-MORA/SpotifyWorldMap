namespace :music_data do
  require 'rubygems'
  require 'nokogiri'

  page = Nokogiri::HTML(RestClient.get("http://everynoise.com/countries.html"))

  task build_everything: :environment do
    columns = page.css('.column').drop(6)
    columns.each do |column|
      country = column.css('.country > text()').text.strip
      country_record = Country.find_or_create_by(name: country)

      genres = column.css('a').map {|a_tag| a_tag.text}

      genres.each do |genre|
        genre_record = Genre.find_or_create_by(name: genre)

        GenresCountry.create(genre_id: genre_record.id, country_id: country_record.id)
      end

    end
  end
end


  # task create_countries: :environment do
  #   countries = page.css('.country > text()').map { |a| a.text}
  #   countries.drop(6).each do |country|
  #     Country.create(
  #       name: country
  #     )
  #   end
  # end
  #
  # task create_genres: :environment do
  #   genres = page.css('.genre').map {|g| g.text}
  #   genres.each do |genre|
  #     Genre.create(
  #       name: genre
  #     )
  #   end
#   end
#
# end
