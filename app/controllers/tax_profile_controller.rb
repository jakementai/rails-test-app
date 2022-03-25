require_relative "../../income_tax"

class TaxProfileController < ApplicationController
  # include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token

  def index
    data = []
    IncomeTaxProfile.all.each do |tax_profile|
      data << tax_profile.to_json
    end
    render json: { data: data }, status: :ok
  end

  def generate_payslip

    # Calculate the payslip
    if !params[:tax_bracket].nil?
      tax_profile = IncomeTax.new(params[:employee_name], params[:gross_income].to_i, params[:tax_bracket])
    else
      tax_profile = IncomeTax.new(params[:employee_name], params[:gross_income].to_i)
    end

    # Insert into DB
    IncomeTaxProfile.create(
      employee_name: params[:employee_name],
      annual_salary: params[:gross_income],
      monthly_income_tax: tax_profile.monthly_income_tax,
    )

    # Return the data back
    render json: {
      "employee_name": tax_profile.name,
      "gross_monthly_income": format_number(tax_profile.gross_monthly_income),
      "monthly_income_tax": format_number(tax_profile.monthly_income_tax),
      "net_monthly_income": format_number(tax_profile.net_monthly_income),
    }, status: :ok
  end

  private

  def format_number(number)
    helpers.number_with_precision(number, precision: 2, separator: ".", delimiter: ",")
  end
end
