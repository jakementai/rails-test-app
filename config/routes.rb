Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/index", to: "tax_profile#index"
  post "/payslip", to: "tax_profile#generate_payslip"
  post "/monthly_salary", to: "tax_profile#compute_monthly_salary"

  namespace :api do
    namespace :v1 do
      get "/payslip", to: "tax_profile#index"
      post "/payslip", to: "tax_profile#generate_payslip"
      get "/payslip/:id", to: "tax_profile#show"
      delete "/payslip/:id", to: "tax_profile#delete_record"
      get "/payslip-form", to: "tax_profile#new"
      get "/csv", to: "tax_profile#generate_csv", defaults: { format: :csv }
    end
  end

  root to: "api/v1/tax_profile#index"
end
