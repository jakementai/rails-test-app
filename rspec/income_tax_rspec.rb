require_relative "../income_tax"

describe IncomeTax do
  context "Tax Income Calculation with $60000 annual income" do
    test_income = IncomeTax.new("Tester", 60000)
    it "Should display total tax to be $6000" do
      expect(sprintf("%.2f", test_income.annual_income_tax)).to eql "6000.00"
    end
    it "Should show correct tax amount based on tax bracket range" do
      expect(test_income.tax_breakdown).to eql [[0.2, 4000.0], [0.1, 2000.0], [0.0, 0.0]]
    end
    it "Should show correct calculation" do
      expect(sprintf("%.2f", test_income.gross_monthly_income)).to eql "5000.00"
      expect(sprintf("%.2f", test_income.monthly_income_tax)).to eql "500.00"
      expect(sprintf("%.2f", test_income.net_monthly_income)).to eql "4500.00"
    end
  end

  context "Tax Income Calculation with $200000 annual income" do
    test_income = IncomeTax.new("Tester", 200000)
    it "Should display total tax to be $48000" do
      expect(sprintf("%.2f", test_income.annual_income_tax)).to eql "48000.00"
    end
    it "Should show correct tax amount based on tax bracket range" do
      expect(test_income.tax_breakdown).to eql [[0.4, 8000.0], [0.3, 30000.0], [0.2, 8000.0], [0.1, 2000.0], [0.0, 0.0]]
    end
    it "Should show correct calculation" do
      expect(sprintf("%.2f", test_income.gross_monthly_income)).to eql "16666.67"
      expect(sprintf("%.2f", test_income.monthly_income_tax)).to eql "4000.00"
      expect(sprintf("%.2f", test_income.net_monthly_income)).to eql "12666.67"
    end
  end

  context "Tax Income Calculation with $80150 annual income" do
    test_income = IncomeTax.new("Tester", 80150)
    it "Should display total tax to be $10045" do
      expect(sprintf("%.2f", test_income.annual_income_tax)).to eql "10045.00"
    end
    it "Should show correct tax amount based on tax bracket range" do
      expect(test_income.tax_breakdown).to eql [[0.3, 45.0], [0.2, 8000.0], [0.1, 2000.0], [0.0, 0.0]]
    end
    it "Should show correct calculation" do
      expect(sprintf("%.2f", test_income.gross_monthly_income)).to eql "6679.17"
      expect(sprintf("%.2f", test_income.monthly_income_tax)).to eql "837.08"
      expect(sprintf("%.2f", test_income.net_monthly_income)).to eql "5842.08"
    end
  end

  context "Tax Income Calculation with $80150 annual income with custom tax bracket" do
    test_income = IncomeTax.new("Tester", 80150, [[10, 50000], [0, 0]])
    it "Should display total tax to be $3015" do
      expect(sprintf("%.2f", test_income.annual_income_tax)).to eql "3015.00"
    end
    it "Should show correct tax amount based on tax bracket range" do
      expect(test_income.tax_breakdown).to eql [[0.1, 3015.00], [0.0, 0.0]]
    end
    it "Should show correct calculation" do
      expect(sprintf("%.2f", test_income.gross_monthly_income)).to eql "6679.17"
      expect(sprintf("%.2f", test_income.monthly_income_tax)).to eql "251.25"
      expect(sprintf("%.2f", test_income.net_monthly_income)).to eql "6427.92"
    end
  end
end
