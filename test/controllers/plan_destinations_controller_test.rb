require 'test_helper'

class PlanDestinationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plan_destinations_new_url
    assert_response :success
  end

end
