require 'test_helper'

class HomeModuloEspetaculosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_modulo_espetaculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_modulo_espetaculo" do
    assert_difference('HomeModuloEspetaculo.count') do
      post :create, :home_modulo_espetaculo => { }
    end

    assert_redirected_to home_modulo_espetaculo_path(assigns(:home_modulo_espetaculo))
  end

  test "should show home_modulo_espetaculo" do
    get :show, :id => home_modulo_espetaculos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => home_modulo_espetaculos(:one).to_param
    assert_response :success
  end

  test "should update home_modulo_espetaculo" do
    put :update, :id => home_modulo_espetaculos(:one).to_param, :home_modulo_espetaculo => { }
    assert_redirected_to home_modulo_espetaculo_path(assigns(:home_modulo_espetaculo))
  end

  test "should destroy home_modulo_espetaculo" do
    assert_difference('HomeModuloEspetaculo.count', -1) do
      delete :destroy, :id => home_modulo_espetaculos(:one).to_param
    end

    assert_redirected_to home_modulo_espetaculos_path
  end
end
