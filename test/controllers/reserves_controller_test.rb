require 'test_helper'

class ReservesControllerTest < ActionController::TestCase
  setup do
    @reserve = reserves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reserves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserve" do
    assert_difference('Reserve.count') do
      post :create, reserve: { hdate: @reserve.hdate, hhv: @reserve.hhv, ldata: @reserve.ldata, llv: @reserve.llv, loss: @reserve.loss, note: @reserve.note, plratio: @reserve.plratio, profit: @reserve.profit, stockstatus: @reserve.stockstatus }
    end

    assert_redirected_to reserve_path(assigns(:reserve))
  end

  test "should show reserve" do
    get :show, id: @reserve
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reserve
    assert_response :success
  end

  test "should update reserve" do
    patch :update, id: @reserve, reserve: { hdate: @reserve.hdate, hhv: @reserve.hhv, ldata: @reserve.ldata, llv: @reserve.llv, loss: @reserve.loss, note: @reserve.note, plratio: @reserve.plratio, profit: @reserve.profit, stockstatus: @reserve.stockstatus }
    assert_redirected_to reserve_path(assigns(:reserve))
  end

  test "should destroy reserve" do
    assert_difference('Reserve.count', -1) do
      delete :destroy, id: @reserve
    end

    assert_redirected_to reserves_path
  end
end
