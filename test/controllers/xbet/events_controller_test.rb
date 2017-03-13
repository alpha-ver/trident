require 'test_helper'

class Xbet::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xbet_event = xbet_events(:one)
  end

  test "should get index" do
    get xbet_events_url
    assert_response :success
  end

  test "should get new" do
    get new_xbet_event_url
    assert_response :success
  end

  test "should create xbet_event" do
    assert_difference('Xbet::Event.count') do
      post xbet_events_url, params: { xbet_event: { commands_ids: @xbet_event.commands_ids, dl: @xbet_event.dl, host_command_id: @xbet_event.host_command_id, message_history: @xbet_event.message_history, score_history: @xbet_event.score_history, slave_command_id: @xbet_event.slave_command_id, sport_id: @xbet_event.sport_id, start_at: @xbet_event.start_at, status: @xbet_event.status } }
    end

    assert_redirected_to xbet_event_url(Xbet::Event.last)
  end

  test "should show xbet_event" do
    get xbet_event_url(@xbet_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_xbet_event_url(@xbet_event)
    assert_response :success
  end

  test "should update xbet_event" do
    patch xbet_event_url(@xbet_event), params: { xbet_event: { commands_ids: @xbet_event.commands_ids, dl: @xbet_event.dl, host_command_id: @xbet_event.host_command_id, message_history: @xbet_event.message_history, score_history: @xbet_event.score_history, slave_command_id: @xbet_event.slave_command_id, sport_id: @xbet_event.sport_id, start_at: @xbet_event.start_at, status: @xbet_event.status } }
    assert_redirected_to xbet_event_url(@xbet_event)
  end

  test "should destroy xbet_event" do
    assert_difference('Xbet::Event.count', -1) do
      delete xbet_event_url(@xbet_event)
    end

    assert_redirected_to xbet_events_url
  end
end
