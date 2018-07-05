class AddUriToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :uri, :string
  end
end
