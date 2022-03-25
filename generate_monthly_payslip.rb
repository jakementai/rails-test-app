require_relative "income_tax"

if !ARGV[2].nil?
  ren_income_tax = IncomeTax.new(ARGV[0], ARGV[1].to_i, ARGV[2], true)
else
  ren_income_tax = IncomeTax.new(ARGV[0], ARGV[1].to_i)
end
puts "----------------------------------------------------------"
puts "Monthly Payslip for: \"#{ren_income_tax.name}\""
puts sprintf("Gross Monthly Income: $%.2f", ren_income_tax.gross_monthly_income)
puts sprintf("Monthly Income Tax: $%.2f", ren_income_tax.monthly_income_tax)
puts sprintf("Net Monthly Income: $%.2f", ren_income_tax.net_monthly_income)
puts "----------------------------------------------------------"
