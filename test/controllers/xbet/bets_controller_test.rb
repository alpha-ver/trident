require 'test_helper'

class Xbet::BetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xbet_bet = xbet_bets(:one)
  end

  test "should get index" do
    get xbet_bets_url
    assert_response :success
  end

  test "should get new" do
    get new_xbet_bet_url
    assert_response :success
  end

  test "should create xbet_bet" do
    assert_difference('Xbet::Bet.count') do
      post xbet_bets_url, params: { xbet_bet: { active: @xbet_bet.active, bettype_id: @xbet_bet.bettype_id, dl: @xbet_bet.dl, event_id: @xbet_bet.event_id, ratio: @xbet_bet.ratio } }
    end

    assert_redirected_to xbet_bet_url(Xbet::Bet.last)
  end

  test "should show xbet_bet" do
    get xbet_bet_url(@xbet_bet)
    assert_response :success
  end

  test "should get edit" do
    get edit_xbet_bet_url(@xbet_bet)
    assert_response :success
  end

  test "should update xbet_bet" do
    patch xbet_bet_url(@xbet_bet), params: { xbet_bet: { active: @xbet_bet.active, bettype_id: @xbet_bet.bettype_id, dl: @xbet_bet.dl, event_id: @xbet_bet.event_id, ratio: @xbet_bet.ratio } }
    assert_redirected_to xbet_bet_url(@xbet_bet)
  end

  test "should destroy xbet_bet" do
    assert_difference('Xbet::Bet.count', -1) do
      delete xbet_bet_url(@xbet_bet)
    end

    assert_redirected_to xbet_bets_url
  end
end
