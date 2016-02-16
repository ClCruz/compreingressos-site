require 'test_helper'

class OutrasLocalidadesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outras_localidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outras_localidade" do
    assert_difference('OutrasLocalidade.count') do
      post :create, :outras_localidade => { }
    end

    assert_redirected_to outras_localidade_path(assigns(:outras_localidade))
  end

  test "should show outras_localidade" do
    get :show, :id => outras_localidades(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => outras_localidades(:one).to_param
    assert_response :success
  end

  test "should update outras_localidade" do
    put :update, :id => outras_localidades(:one).to_param, :outras_localidade => { }
    assert_redirected_to outras_localidade_path(assigns(:outras_localidade))
  end

  test "should destroy outras_localidade" do
    assert_difference('OutrasLocalidade.count', -1) do
      delete :destroy, :id => outras_localidades(:one).to_param
    end

    assert_redirected_to outras_localidades_path
  end
end
