require 'test_helper'

class Bet::GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_group = bet_groups(:one)
  end

  test "should get index" do
    get bet_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_group_url
    assert_response :success
  end

  test "should create bet_group" do
    assert_difference('Bet::Group.count') do
      post bet_groups_url, params: { bet_group: { api_xbet_id: @bet_group.api_xbet_id, api_xbet_params: @bet_group.api_xbet_params, created: @bet_group.created, find_names: @bet_group.find_names, name: @bet_group.name } }
    end

    assert_redirected_to bet_group_url(Bet::Group.last)
  end

  test "should show bet_group" do
    get bet_group_url(@bet_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_group_url(@bet_group)
    assert_response :success
  end

  test "should update bet_group" do
    patch bet_group_url(@bet_group), params: { bet_group: { api_xbet_id: @bet_group.api_xbet_id, api_xbet_params: @bet_group.api_xbet_params, created: @bet_group.created, find_names: @bet_group.find_names, name: @bet_group.name } }
    assert_redirected_to bet_group_url(@bet_group)
  end

  test "should destroy bet_group" do
    assert_difference('Bet::Group.count', -1) do
      delete bet_group_url(@bet_group)
    end

    assert_redirected_to bet_groups_url
  end
end
