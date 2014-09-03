require 'test_helper'

class WeixinlogsControllerTest < ActionController::TestCase
  setup do
    @weixinlog = weixinlogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weixinlogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weixinlog" do
    assert_difference('Weixinlog.count') do
      post :create, weixinlog: { content: @weixinlog.content, time: @weixinlog.time }
    end

    assert_redirected_to weixinlog_path(assigns(:weixinlog))
  end

  test "should show weixinlog" do
    get :show, id: @weixinlog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weixinlog
    assert_response :success
  end

  test "should update weixinlog" do
    patch :update, id: @weixinlog, weixinlog: { content: @weixinlog.content, time: @weixinlog.time }
    assert_redirected_to weixinlog_path(assigns(:weixinlog))
  end

  test "should destroy weixinlog" do
    assert_difference('Weixinlog.count', -1) do
      delete :destroy, id: @weixinlog
    end

    assert_redirected_to weixinlogs_path
  end
end
