require 'test_helper'

class MarketdatesControllerTest < ActionController::TestCase
  setup do
    @marketdate = marketdates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marketdates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marketdate" do
    assert_difference('Marketdate.count') do
      post :create, marketdate: { daystate: @marketdate.daystate, tradedate: @marketdate.tradedate }
    end

    assert_redirected_to marketdate_path(assigns(:marketdate))
  end

  test "should show marketdate" do
    get :show, id: @marketdate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marketdate
    assert_response :success
  end

  test "should update marketdate" do
    patch :update, id: @marketdate, marketdate: { daystate: @marketdate.daystate, tradedate: @marketdate.tradedate }
    assert_redirected_to marketdate_path(assigns(:marketdate))
  end

  test "should destroy marketdate" do
    assert_difference('Marketdate.count', -1) do
      delete :destroy, id: @marketdate
    end

    assert_redirected_to marketdates_path
  end
end
