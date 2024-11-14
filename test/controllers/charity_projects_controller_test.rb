require "test_helper"

class CharityProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get charity_projects_index_url
    assert_response :success
  end
end
