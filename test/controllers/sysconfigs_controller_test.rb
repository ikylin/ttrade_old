require 'test_helper'

class SysconfigsControllerTest < ActionController::TestCase
  setup do
    @sysconfig = sysconfigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sysconfigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sysconfig" do
    assert_difference('Sysconfig.count') do
      post :create, sysconfig: { batchend: @sysconfig.batchend, batchstart: @sysconfig.batchstart, marketdate: @sysconfig.marketdate }
    end

    assert_redirected_to sysconfig_path(assigns(:sysconfig))
  end

  test "should show sysconfig" do
    get :show, id: @sysconfig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sysconfig
    assert_response :success
  end

  test "should update sysconfig" do
    patch :update, id: @sysconfig, sysconfig: { batchend: @sysconfig.batchend, batchstart: @sysconfig.batchstart, marketdate: @sysconfig.marketdate }
    assert_redirected_to sysconfig_path(assigns(:sysconfig))
  end

  test "should destroy sysconfig" do
    assert_difference('Sysconfig.count', -1) do
      delete :destroy, id: @sysconfig
    end

    assert_redirected_to sysconfigs_path
  end
end
