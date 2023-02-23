require "test_helper"

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get elections" do
    get app_elections_url
    assert_response :success
  end

  test "should get election" do
    get app_election_url
    assert_response :success
  end
end
