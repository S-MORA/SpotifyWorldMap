class AddUriToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :uri, :string
  end
end
