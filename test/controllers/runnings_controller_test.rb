require 'test_helper'

class RunningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @running = runnings(:one)
  end

  test "should get index" do
    get runnings_url
    assert_response :success
  end

  test "should get new" do
    get new_running_url
    assert_response :success
  end

  test "should create running" do
    assert_difference('Running.count') do
      post runnings_url, params: { running: { name: @running.name, one_lap: @running.one_lap, three_lap: @running.three_lap, total: @running.total, two_lap: @running.two_lap } }
    end

    assert_redirected_to running_url(Running.last)
  end

  test "should show running" do
    get running_url(@running)
    assert_response :success
  end

  test "should get edit" do
    get edit_running_url(@running)
    assert_response :success
  end

  test "should update running" do
    patch running_url(@running), params: { running: { name: @running.name, one_lap: @running.one_lap, three_lap: @running.three_lap, total: @running.total, two_lap: @running.two_lap } }
    assert_redirected_to running_url(@running)
  end

  test "should destroy running" do
    assert_difference('Running.count', -1) do
      delete running_url(@running)
    end

    assert_redirected_to runnings_url
  end
end
