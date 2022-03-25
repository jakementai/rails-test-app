class IncomeTax
  attr_accessor :name, :annual_gross_salary, :tax_bracket
  @@TAX_BRACKET = [[40, 180_000], [30, 80_000], [20, 40_000], [10, 20_000], [0, 0]]

  # Init
  def initialize(name, annual_gross_salary, tax_bracket = @@TAX_BRACKET, parse = false)
    @name = name
    @annual_gross_salary = annual_gross_salary
    @tax_bracket = parse ? parse_tax_bracket(tax_bracket) : tax_bracket
  end

  # Method
  def annual_income_tax
    if @annual_income_tax.nil?
      @annual_income_tax = calculate_annual_tax
    else
      @annual_income_tax
    end
  end

  def monthly_income_tax
    annual_income_tax / 12.0
  end

  def net_monthly_income
    (@annual_gross_salary - annual_income_tax) / 12.0
  end

  def gross_monthly_income
    annual_gross_salary / 12.0
  end

  def tax_breakdown
    if @tax_breakdown.nil?
      calculate_annual_tax
      @tax_breakdown
    else
      @tax_breakdown
    end
  end

  private

  def calculate_annual_tax
    # Variables
    remaining_salary = @annual_gross_salary
    total_tax = 0
    @tax_breakdown = []
    # foreach loop to calculate total income tax
    @tax_bracket.each do |bracket|
      taxible_income = remaining_salary - bracket[1].to_i
      tax_rate = bracket[0].to_i / 100.00
      if taxible_income.positive?
        total_tax += taxible_income * tax_rate
        remaining_salary -= taxible_income
        @tax_breakdown << [tax_rate, taxible_income * tax_rate]
      end
    end
    total_tax
  end

  def parse_tax_bracket(tax_bracket)
    puts "tax_bracket before: #{tax_bracket}"
    tax_bracket = tax_bracket.gsub(/[\[\]]/, "")
    puts tax_bracket
    custom_tax_bracket = []
    # Parse the Arguments
    tax_bracket.split(",").each do |args|
      custom_tax_bracket += [args.split(":").map(&:to_i)]
    end
    custom_tax_bracket
  end
end
