require 'test_helper'

class HomeModulosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_modulos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_modulo" do
    assert_difference('HomeModulo.count') do
      post :create, :home_modulo => { }
    end

    assert_redirected_to home_modulo_path(assigns(:home_modulo))
  end

  test "should show home_modulo" do
    get :show, :id => home_modulos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => home_modulos(:one).to_param
    assert_response :success
  end

  test "should update home_modulo" do
    put :update, :id => home_modulos(:one).to_param, :home_modulo => { }
    assert_redirected_to home_modulo_path(assigns(:home_modulo))
  end

  test "should destroy home_modulo" do
    assert_difference('HomeModulo.count', -1) do
      delete :destroy, :id => home_modulos(:one).to_param
    end

    assert_redirected_to home_modulos_path
  end
end
