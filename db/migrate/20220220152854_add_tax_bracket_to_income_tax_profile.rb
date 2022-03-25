class AddTaxBracketToIncomeTaxProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :income_tax_profiles, :tax_bracket, :string
  end
end
