class AddAddressToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :address, :string
    add_column :countries, :latitude, :float
    add_column :countries, :longitude, :float
  end
end
