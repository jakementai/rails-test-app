require "test_helper"

class IncomeTaxProfileTest < ActiveSupport::TestCase
  test "Should not save without employee name and gross annual salary" do
    tax_profile = IncomeTaxProfile.new
    assert_not tax_profile.save
  end

  test "Should retrieve correct data" do
    tax_profile = IncomeTaxProfile.find(1)
    assert_equal income_tax_profiles(:ren), tax_profile
  end
end
