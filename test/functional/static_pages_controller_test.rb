require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get billing_info" do
    get :billing_info
    assert_response :success
  end

end
