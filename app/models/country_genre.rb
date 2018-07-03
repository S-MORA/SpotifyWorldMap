class CountryGenre < ApplicationRecord
  belongs_to :country
  belongs_to :genre
end
