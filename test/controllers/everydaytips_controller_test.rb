require 'test_helper'

class EverydaytipsControllerTest < ActionController::TestCase
  setup do
    @everydaytip = everydaytips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:everydaytips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create everydaytip" do
    assert_difference('Everydaytip.count') do
      post :create, everydaytip: { tip: @everydaytip.tip }
    end

    assert_redirected_to everydaytip_path(assigns(:everydaytip))
  end

  test "should show everydaytip" do
    get :show, id: @everydaytip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @everydaytip
    assert_response :success
  end

  test "should update everydaytip" do
    patch :update, id: @everydaytip, everydaytip: { tip: @everydaytip.tip }
    assert_redirected_to everydaytip_path(assigns(:everydaytip))
  end

  test "should destroy everydaytip" do
    assert_difference('Everydaytip.count', -1) do
      delete :destroy, id: @everydaytip
    end

    assert_redirected_to everydaytips_path
  end
end
