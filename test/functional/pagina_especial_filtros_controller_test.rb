require 'test_helper'

class PaginaEspecialFiltrosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagina_especial_filtros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagina_especial_filtro" do
    assert_difference('PaginaEspecialFiltro.count') do
      post :create, :pagina_especial_filtro => { }
    end

    assert_redirected_to pagina_especial_filtro_path(assigns(:pagina_especial_filtro))
  end

  test "should show pagina_especial_filtro" do
    get :show, :id => pagina_especial_filtros(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pagina_especial_filtros(:one).to_param
    assert_response :success
  end

  test "should update pagina_especial_filtro" do
    put :update, :id => pagina_especial_filtros(:one).to_param, :pagina_especial_filtro => { }
    assert_redirected_to pagina_especial_filtro_path(assigns(:pagina_especial_filtro))
  end

  test "should destroy pagina_especial_filtro" do
    assert_difference('PaginaEspecialFiltro.count', -1) do
      delete :destroy, :id => pagina_especial_filtros(:one).to_param
    end

    assert_redirected_to pagina_especial_filtros_path
  end
end
