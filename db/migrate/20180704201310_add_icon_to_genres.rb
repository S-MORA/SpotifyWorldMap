class AddIconToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :icon, :string
  end
end
