require "test_helper"

class TaxProfileControllerTest < ActionDispatch::IntegrationTest
  test "Should redirect to root path" do
    get root_url
    assert_response :success
  end

  test "Get Index Path should work" do
    get api_v1_payslip_url
    assert_response :success
  end

  test "Get payslip form path should work" do
    get api_v1_payslip_form_url
    assert_response :success
  end

  test "Get single payslip should work" do
    get api_v1_url(income_tax_profiles(:ren))
    assert_response :success
  end

  test "Get single payslip as json" do
    get api_v1_url(income_tax_profiles(:ren)), as: :json
    response_json = @response.parsed_body
    assert_equal response_json.stringify_keys, income_tax_profiles(:ren).to_json.stringify_keys
  end

  test "Get index as json" do
    get api_v1_payslip_url, as: :json
    response_json = @response.parsed_body
    assert_equal response_json, income_tax_profiles.map { |p| p.to_json.stringify_keys }
  end

  test "Post new payslip" do
    assert_difference("IncomeTaxProfile.count") do
      post api_v1_payslip_path, params: { tax_profile: { employee_name: "Test Employee", gross_annual_income: 50000, tax_bracket: [] } }, as: :json
    end
    assert_equal @response.parsed_body, IncomeTaxProfile.last.to_json.stringify_keys
  end

  test "Delete payslip" do
    assert_difference("IncomeTaxProfile.count", differences = -1) do
      delete api_v1_path(income_tax_profiles(:ren)), as: :json
    end

    assert_equal @response.parsed_body, { message: "Deleted Successfully" }.stringify_keys
    assert_equal @response.status, 202
  end
end
