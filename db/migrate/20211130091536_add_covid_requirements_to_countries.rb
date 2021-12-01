class AddCovidRequirementsToCountries < ActiveRecord::Migration[6.1]
  def change
    add_column :countries, :covid_requirements, :text
  end
end
