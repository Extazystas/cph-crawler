require 'test_helper'

class ArrivalsControllerTest < ActionDispatch::IntegrationTest
  test "when internet connection is broken" do
    stub_request(:any, 'https://www.cph.dk/en/flight-information/arrivals/').to_raise(SocketError)

    get arrivals_path, as: :json

    assert_response 422
    assert_equal 'application/json', @response.content_type
    assert_equal "Error: No Internet connection.", JSON.parse(@response.body)['errors']
  end

  test "should get index" do
    WebMock.disable_net_connect!(allow: 'www.cph.dk')
    get arrivals_path, as: :json

    assert_response :success
    assert_equal 'application/json', @response.content_type
  end
end
