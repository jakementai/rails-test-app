class IncomeTaxProfile < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  validates :employee_name, :annual_salary, presence: true

  def net_annual_salary
    format_number(attributes["annual_salary"] - attributes["monthly_income_tax"] * 12.0)
  end

  def net_monthly_salary
    format_number(attributes["annual_salary"] / 12.0 - attributes["monthly_income_tax"])
  end

  def annual_income_tax
    format_number(attributes["monthly_income_tax"] * 12.0)
  end

  def gross_monthly_salary
    format_number(attributes["annual_salary"] / 12.0)
  end

  def tax_bracket
    temp_arr = attributes["tax_bracket"][2..-3].gsub(/\], \[/, "|")
    tax_bracket = []
    temp_arr.split("|").each do |bracket|
      tax_bracket += [bracket.split(",").map(&:to_i)]
    end
    tax_bracket
  end

  def to_json
    if attributes.empty?
      {}
    else
      {
        "id": attributes["id"],
        "employee_name": attributes["employee_name"],
        "updated_at": attributes["updated_at"].strftime("%d/%m/%Y %I:%M %p"),
        "gross_annual_salary": format_number(attributes["annual_salary"]),
        "annual_income_tax": annual_income_tax,
        "net_annual_salary": net_annual_salary,
        "gross_monthly_salary": gross_monthly_salary,
        "monthly_income_tax": format_number(attributes["monthly_income_tax"]),
        "net_monthly_salary": net_monthly_salary,
        "tax_bracket": tax_bracket,
      }
    end
  end

  private

  def format_number(number)
    number_with_precision(number, precision: 2, separator: ".", delimiter: ",")
  end
end
