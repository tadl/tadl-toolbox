require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  test "should get show_lists" do
    get :show_lists
    assert_response :success
  end

  test "should get create_lists" do
    get :create_lists
    assert_response :success
  end

  test "should get edit_lists" do
    get :edit_lists
    assert_response :success
  end

  test "should get my_lists" do
    get :my_lists
    assert_response :success
  end

end
