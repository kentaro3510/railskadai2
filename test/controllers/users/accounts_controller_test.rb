require "test_helper"

class Users::AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_accounts_show_url
    assert_response :success
  end
end