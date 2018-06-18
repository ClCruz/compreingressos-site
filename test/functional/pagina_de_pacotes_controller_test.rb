require 'test_helper'

class PaginaDePacotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagina_de_pacotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagina_de_pacote" do
    assert_difference('PaginaDePacote.count') do
      post :create, :pagina_de_pacote => { }
    end

    assert_redirected_to pagina_de_pacote_path(assigns(:pagina_de_pacote))
  end

  test "should show pagina_de_pacote" do
    get :show, :id => pagina_de_pacotes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pagina_de_pacotes(:one).to_param
    assert_response :success
  end

  test "should update pagina_de_pacote" do
    put :update, :id => pagina_de_pacotes(:one).to_param, :pagina_de_pacote => { }
    assert_redirected_to pagina_de_pacote_path(assigns(:pagina_de_pacote))
  end

  test "should destroy pagina_de_pacote" do
    assert_difference('PaginaDePacote.count', -1) do
      delete :destroy, :id => pagina_de_pacotes(:one).to_param
    end

    assert_redirected_to pagina_de_pacotes_path
  end
end
