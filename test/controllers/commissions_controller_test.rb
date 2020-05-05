require 'test_helper'

class CommissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get commissions_index_url
    assert_response :success
  end

  test "should get show" do
    get commissions_show_url
    assert_response :success
  end

  test "should get new" do
    get commissions_new_url
    assert_response :success
  end

  test "should get edit" do
    get commissions_edit_url
    assert_response :success
  end

end
