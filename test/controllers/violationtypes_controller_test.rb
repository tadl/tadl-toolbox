require 'test_helper'

class ViolationtypesControllerTest < ActionController::TestCase
  setup do
    @violationtype = violationtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:violationtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create violationtype" do
    assert_difference('Violationtype.count') do
      post :create, violationtype: { description: @violationtype.description, first_offence: @violationtype.first_offence, second_offence: @violationtype.second_offence, subsiquent_offence: @violationtype.subsiquent_offence }
    end

    assert_redirected_to violationtype_path(assigns(:violationtype))
  end

  test "should show violationtype" do
    get :show, id: @violationtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @violationtype
    assert_response :success
  end

  test "should update violationtype" do
    patch :update, id: @violationtype, violationtype: { description: @violationtype.description, first_offence: @violationtype.first_offence, second_offence: @violationtype.second_offence, subsiquent_offence: @violationtype.subsiquent_offence }
    assert_redirected_to violationtype_path(assigns(:violationtype))
  end

  test "should destroy violationtype" do
    assert_difference('Violationtype.count', -1) do
      delete :destroy, id: @violationtype
    end

    assert_redirected_to violationtypes_path
  end
end
