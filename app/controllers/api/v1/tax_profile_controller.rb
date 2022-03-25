require_relative "../../../../income_tax"
require "csv"

module Api::V1
  class TaxProfileController < ApplicationController
    # include ActionView::Helpers::NumberHelper
    skip_before_action :verify_authenticity_token

    def index
      @count = 1
      @income_tax_profiles = IncomeTaxProfile.all.map(&:to_json)

      respond_to do |format|
        format.html
        format.json { render json: @income_tax_profiles, status: :ok }
      end
    end

    def generate_csv
      @tax_profiles = IncomeTaxProfile.all

      respond_to do |format|
        format.csv do
          response.headers["Content-Type"] = "text/csv"
          response.headers["Content-Disposition"] = "attachment; filename=employee_payroll.csv"
          render template: "api/v1/tax_profile/export.csv.erb"
        end
      end
    end

    def show
      @tax_profile = (IncomeTaxProfile.find(params[:id])).to_json
      respond_to do |format|
        format.html
        format.json { render json: @tax_profile, status: :ok }
      end
    end

    def delete_record
      IncomeTaxProfile.destroy(params[:id])
      respond_to do |format|
        format.html { redirect_to api_v1_payslip_path }
        format.json { render json: { message: "Deleted Successfully" }, status: :accepted }
      end
    end

    def generate_payslip
      tax_profile_param = params[:tax_profile]
      # Calculate the payslip
      unless tax_profile_param[:tax_bracket].empty?
        tax_profile = IncomeTax.new(tax_profile_param[:employee_name], tax_profile_param[:gross_annual_income].to_i, tax_profile_param[:tax_bracket], true)
      else
        tax_profile = IncomeTax.new(tax_profile_param[:employee_name], tax_profile_param[:gross_annual_income].to_i)
      end

      # Insert into DB
      new_profile = IncomeTaxProfile.create(
        employee_name: tax_profile_param[:employee_name],
        annual_salary: tax_profile_param[:gross_annual_income],
        monthly_income_tax: tax_profile.monthly_income_tax,
        tax_bracket: tax_profile.tax_bracket,
      )

      # Return the data back
      if new_profile.errors.empty?
        respond_to do |format|
          format.html { redirect_to api_v1_path(new_profile.id) }
          format.json { render json: new_profile.to_json, status: :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to api_v1_payslip_path, errors: new_profile.errors }
          format.json { render json: { message: "Created Unsucessfully" } }
        end
      end
    end
  end
end
