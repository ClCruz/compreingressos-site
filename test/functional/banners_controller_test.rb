require 'test_helper'

class BannersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banners" do
    assert_difference('Banners.count') do
      post :create, :banners => { }
    end

    assert_redirected_to banners_path(assigns(:banners))
  end

  test "should show banners" do
    get :show, :id => banners(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => banners(:one).to_param
    assert_response :success
  end

  test "should update banners" do
    put :update, :id => banners(:one).to_param, :banners => { }
    assert_redirected_to banners_path(assigns(:banners))
  end

  test "should destroy banners" do
    assert_difference('Banners.count', -1) do
      delete :destroy, :id => banners(:one).to_param
    end

    assert_redirected_to banners_path
  end
end
