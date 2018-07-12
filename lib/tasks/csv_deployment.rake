require 'csv'

task csv_deployment: :environment do
  CSV.foreach("./lib/assets/genres.csv") do |data_row|
  	unless data_row[0] == 'id'
  		genre = Genre.create(
  			name: data_row[1],
  			icon: data_row[4],
  			uri: data_row[5],
  		)
  	end
  end

  CSV.foreach("./lib/assets/countries.csv") do |data_row|
  	unless data_row[0] == 'id'
  		country = Country.create(
  			name: data_row[1],
  			uri: data_row[4],
  		)
  	end
  end

  CSV.foreach("./lib/assets/country_genres.csv") do |data_row|
  	unless data_row[0] == 'id'
  		country_genre = CountryGenre.create(
  			country_id: data_row[1],
  			genre_id: data_row[2],
  		)
  	end
  end
end
