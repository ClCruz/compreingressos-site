require 'test_helper'

class EspetaculosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:espetaculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create espetaculo" do
    assert_difference('Espetaculo.count') do
      post :create, :espetaculo => { }
    end

    assert_redirected_to espetaculo_path(assigns(:espetaculo))
  end

  test "should show espetaculo" do
    get :show, :id => espetaculos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => espetaculos(:one).to_param
    assert_response :success
  end

  test "should update espetaculo" do
    put :update, :id => espetaculos(:one).to_param, :espetaculo => { }
    assert_redirected_to espetaculo_path(assigns(:espetaculo))
  end

  test "should destroy espetaculo" do
    assert_difference('Espetaculo.count', -1) do
      delete :destroy, :id => espetaculos(:one).to_param
    end

    assert_redirected_to espetaculos_path
  end
end
