require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invoices_index_url
    assert_response :success
  end

  test "should get destroy" do
    get invoices_destroy_url
    assert_response :success
  end
end
