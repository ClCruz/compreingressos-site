require 'test_helper'

class CidadeVisoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cidade_visores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cidade_visor" do
    assert_difference('CidadeVisor.count') do
      post :create, :cidade_visor => { }
    end

    assert_redirected_to cidade_visor_path(assigns(:cidade_visor))
  end

  test "should show cidade_visor" do
    get :show, :id => cidade_visores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cidade_visores(:one).to_param
    assert_response :success
  end

  test "should update cidade_visor" do
    put :update, :id => cidade_visores(:one).to_param, :cidade_visor => { }
    assert_redirected_to cidade_visor_path(assigns(:cidade_visor))
  end

  test "should destroy cidade_visor" do
    assert_difference('CidadeVisor.count', -1) do
      delete :destroy, :id => cidade_visores(:one).to_param
    end

    assert_redirected_to cidade_visores_path
  end
end
