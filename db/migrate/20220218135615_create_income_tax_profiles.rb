class CreateIncomeTaxProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :income_tax_profiles do |t|
      t.string :employee_name
      t.decimal :annual_salary
      t.decimal :monthly_income_tax

      t.timestamps
    end
  end
end
