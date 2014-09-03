require 'test_helper'

class PortfoliologsControllerTest < ActionController::TestCase
  setup do
    @portfoliolog = portfoliologs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:portfoliologs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create portfoliolog" do
    assert_difference('Portfoliolog.count') do
      post :create, portfoliolog: { opt: @portfoliolog.opt, time: @portfoliolog.time }
    end

    assert_redirected_to portfoliolog_path(assigns(:portfoliolog))
  end

  test "should show portfoliolog" do
    get :show, id: @portfoliolog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @portfoliolog
    assert_response :success
  end

  test "should update portfoliolog" do
    patch :update, id: @portfoliolog, portfoliolog: { opt: @portfoliolog.opt, time: @portfoliolog.time }
    assert_redirected_to portfoliolog_path(assigns(:portfoliolog))
  end

  test "should destroy portfoliolog" do
    assert_difference('Portfoliolog.count', -1) do
      delete :destroy, id: @portfoliolog
    end

    assert_redirected_to portfoliologs_path
  end
end
