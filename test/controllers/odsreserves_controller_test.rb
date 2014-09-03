require 'test_helper'

class OdsreservesControllerTest < ActionController::TestCase
  setup do
    @odsreserf = odsreserves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:odsreserves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create odsreserf" do
    assert_difference('Odsreserf.count') do
      post :create, odsreserf: { close: @odsreserf.close, code: @odsreserf.code, dprofit: @odsreserf.dprofit, duration: @odsreserf.duration, high: @odsreserf.high, low: @odsreserf.low, name: @odsreserf.name, open: @odsreserf.open, plate: @odsreserf.plate }
    end

    assert_redirected_to odsreserf_path(assigns(:odsreserf))
  end

  test "should show odsreserf" do
    get :show, id: @odsreserf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @odsreserf
    assert_response :success
  end

  test "should update odsreserf" do
    patch :update, id: @odsreserf, odsreserf: { close: @odsreserf.close, code: @odsreserf.code, dprofit: @odsreserf.dprofit, duration: @odsreserf.duration, high: @odsreserf.high, low: @odsreserf.low, name: @odsreserf.name, open: @odsreserf.open, plate: @odsreserf.plate }
    assert_redirected_to odsreserf_path(assigns(:odsreserf))
  end

  test "should destroy odsreserf" do
    assert_difference('Odsreserf.count', -1) do
      delete :destroy, id: @odsreserf
    end

    assert_redirected_to odsreserves_path
  end
end
