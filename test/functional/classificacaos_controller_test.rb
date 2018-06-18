require 'test_helper'

class ClassificacaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classificacaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classificacao" do
    assert_difference('Classificacao.count') do
      post :create, :classificacao => { }
    end

    assert_redirected_to classificacao_path(assigns(:classificacao))
  end

  test "should show classificacao" do
    get :show, :id => classificacaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => classificacaos(:one).to_param
    assert_response :success
  end

  test "should update classificacao" do
    put :update, :id => classificacaos(:one).to_param, :classificacao => { }
    assert_redirected_to classificacao_path(assigns(:classificacao))
  end

  test "should destroy classificacao" do
    assert_difference('Classificacao.count', -1) do
      delete :destroy, :id => classificacaos(:one).to_param
    end

    assert_redirected_to classificacaos_path
  end
end
