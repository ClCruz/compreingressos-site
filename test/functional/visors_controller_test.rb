require 'test_helper'

class VisorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visor" do
    assert_difference('Visor.count') do
      post :create, :visor => { }
    end

    assert_redirected_to visor_path(assigns(:visor))
  end

  test "should show visor" do
    get :show, :id => visors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => visors(:one).to_param
    assert_response :success
  end

  test "should update visor" do
    put :update, :id => visors(:one).to_param, :visor => { }
    assert_redirected_to visor_path(assigns(:visor))
  end

  test "should destroy visor" do
    assert_difference('Visor.count', -1) do
      delete :destroy, :id => visors(:one).to_param
    end

    assert_redirected_to visors_path
  end
end
