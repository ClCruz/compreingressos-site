require 'test_helper'

class GenerosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genero" do
    assert_difference('Genero.count') do
      post :create, :genero => { }
    end

    assert_redirected_to genero_path(assigns(:genero))
  end

  test "should show genero" do
    get :show, :id => generos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => generos(:one).to_param
    assert_response :success
  end

  test "should update genero" do
    put :update, :id => generos(:one).to_param, :genero => { }
    assert_redirected_to genero_path(assigns(:genero))
  end

  test "should destroy genero" do
    assert_difference('Genero.count', -1) do
      delete :destroy, :id => generos(:one).to_param
    end

    assert_redirected_to generos_path
  end
end
