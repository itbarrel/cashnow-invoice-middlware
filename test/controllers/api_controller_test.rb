require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_create_url
    assert_response :success
  end

  test "should get new" do
    get api_new_url
    assert_response :success
  end

  test "should get update" do
    get api_update_url
    assert_response :success
  end

  test "should get edit" do
    get api_edit_url
    assert_response :success
  end

  test "should get delete" do
    get api_delete_url
    assert_response :success
  end
end
