require 'test_helper'

class AnalystsControllerTest < ActionController::TestCase
  setup do
    @analyst = analysts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analyst" do
    assert_difference('Analyst.count') do
      post :create, analyst: { fan: @analyst.fan, lvl: @analyst.lvl, name: @analyst.name }
    end

    assert_redirected_to analyst_path(assigns(:analyst))
  end

  test "should show analyst" do
    get :show, id: @analyst
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analyst
    assert_response :success
  end

  test "should update analyst" do
    patch :update, id: @analyst, analyst: { fan: @analyst.fan, lvl: @analyst.lvl, name: @analyst.name }
    assert_redirected_to analyst_path(assigns(:analyst))
  end

  test "should destroy analyst" do
    assert_difference('Analyst.count', -1) do
      delete :destroy, id: @analyst
    end

    assert_redirected_to analysts_path
  end
end
