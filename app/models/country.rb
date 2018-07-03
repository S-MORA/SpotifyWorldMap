class Country < ApplicationRecord
  has_many :country_genres
  has_many :genres, through: :country_genres
end
