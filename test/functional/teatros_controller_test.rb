require 'test_helper'

class TeatrosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teatros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teatro" do
    assert_difference('Teatro.count') do
      post :create, :teatro => { }
    end

    assert_redirected_to teatro_path(assigns(:teatro))
  end

  test "should show teatro" do
    get :show, :id => teatros(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => teatros(:one).to_param
    assert_response :success
  end

  test "should update teatro" do
    put :update, :id => teatros(:one).to_param, :teatro => { }
    assert_redirected_to teatro_path(assigns(:teatro))
  end

  test "should destroy teatro" do
    assert_difference('Teatro.count', -1) do
      delete :destroy, :id => teatros(:one).to_param
    end

    assert_redirected_to teatros_path
  end
end
