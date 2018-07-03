class Genre < ApplicationRecord
  has_many :country_genres
  has_many :countries, through: :country_genres
end
