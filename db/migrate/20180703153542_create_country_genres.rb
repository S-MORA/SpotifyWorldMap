class CreateCountryGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :country_genres do |t|
      t.references :country, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
