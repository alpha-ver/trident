require 'test_helper'

class Bet::CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_company = bet_companies(:one)
  end

  test "should get index" do
    get bet_companies_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_company_url
    assert_response :success
  end

  test "should create bet_company" do
    assert_difference('Bet::Company.count') do
      post bet_companies_url, params: { bet_company: { about: @bet_company.about, class: @bet_company.class, enable: @bet_company.enable, name: @bet_company.name } }
    end

    assert_redirected_to bet_company_url(Bet::Company.last)
  end

  test "should show bet_company" do
    get bet_company_url(@bet_company)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_company_url(@bet_company)
    assert_response :success
  end

  test "should update bet_company" do
    patch bet_company_url(@bet_company), params: { bet_company: { about: @bet_company.about, class: @bet_company.class, enable: @bet_company.enable, name: @bet_company.name } }
    assert_redirected_to bet_company_url(@bet_company)
  end

  test "should destroy bet_company" do
    assert_difference('Bet::Company.count', -1) do
      delete bet_company_url(@bet_company)
    end

    assert_redirected_to bet_companies_url
  end
end
