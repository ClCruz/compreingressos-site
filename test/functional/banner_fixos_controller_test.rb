require 'test_helper'

class BannerFixosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banner_fixos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner_fixo" do
    assert_difference('BannerFixo.count') do
      post :create, :banner_fixo => { }
    end

    assert_redirected_to banner_fixo_path(assigns(:banner_fixo))
  end

  test "should show banner_fixo" do
    get :show, :id => banner_fixos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => banner_fixos(:one).to_param
    assert_response :success
  end

  test "should update banner_fixo" do
    put :update, :id => banner_fixos(:one).to_param, :banner_fixo => { }
    assert_redirected_to banner_fixo_path(assigns(:banner_fixo))
  end

  test "should destroy banner_fixo" do
    assert_difference('BannerFixo.count', -1) do
      delete :destroy, :id => banner_fixos(:one).to_param
    end

    assert_redirected_to banner_fixos_path
  end
end
