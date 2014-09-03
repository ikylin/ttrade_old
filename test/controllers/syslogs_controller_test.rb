require 'test_helper'

class SyslogsControllerTest < ActionController::TestCase
  setup do
    @syslog = syslogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:syslogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create syslog" do
    assert_difference('Syslog.count') do
      post :create, syslog: { curstate: @syslog.curstate, opt: @syslog.opt, role: @syslog.role, time: @syslog.time }
    end

    assert_redirected_to syslog_path(assigns(:syslog))
  end

  test "should show syslog" do
    get :show, id: @syslog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @syslog
    assert_response :success
  end

  test "should update syslog" do
    patch :update, id: @syslog, syslog: { curstate: @syslog.curstate, opt: @syslog.opt, role: @syslog.role, time: @syslog.time }
    assert_redirected_to syslog_path(assigns(:syslog))
  end

  test "should destroy syslog" do
    assert_difference('Syslog.count', -1) do
      delete :destroy, id: @syslog
    end

    assert_redirected_to syslogs_path
  end
end
