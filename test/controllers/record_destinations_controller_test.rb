require 'test_helper'

class RecordDestinationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_destinations_new_url
    assert_response :success
  end

end
