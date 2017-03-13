require 'test_helper'

class ChampsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @champ = champs(:one)
  end

  test "should get index" do
    get champs_url
    assert_response :success
  end

  test "should get new" do
    get new_champ_url
    assert_response :success
  end

  test "should create champ" do
    assert_difference('Champ.count') do
      post champs_url, params: { champ: { api_xbet_id: @champ.api_xbet_id, api_xbet_params: @champ.api_xbet_params, created: @champ.created, find_names: @champ.find_names, name: @champ.name, sport_id: @champ.sport_id } }
    end

    assert_redirected_to champ_url(Champ.last)
  end

  test "should show champ" do
    get champ_url(@champ)
    assert_response :success
  end

  test "should get edit" do
    get edit_champ_url(@champ)
    assert_response :success
  end

  test "should update champ" do
    patch champ_url(@champ), params: { champ: { api_xbet_id: @champ.api_xbet_id, api_xbet_params: @champ.api_xbet_params, created: @champ.created, find_names: @champ.find_names, name: @champ.name, sport_id: @champ.sport_id } }
    assert_redirected_to champ_url(@champ)
  end

  test "should destroy champ" do
    assert_difference('Champ.count', -1) do
      delete champ_url(@champ)
    end

    assert_redirected_to champs_url
  end
end
