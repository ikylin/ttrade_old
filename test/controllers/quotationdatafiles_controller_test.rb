require 'test_helper'

class QuotationdatafilesControllerTest < ActionController::TestCase
  setup do
    @quotationdatafile = quotationdatafiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotationdatafiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotationdatafile" do
    assert_difference('Quotationdatafile.count') do
      post :create, quotationdatafile: { filestatus: @quotationdatafile.filestatus, filetype: @quotationdatafile.filetype }
    end

    assert_redirected_to quotationdatafile_path(assigns(:quotationdatafile))
  end

  test "should show quotationdatafile" do
    get :show, id: @quotationdatafile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quotationdatafile
    assert_response :success
  end

  test "should update quotationdatafile" do
    patch :update, id: @quotationdatafile, quotationdatafile: { filestatus: @quotationdatafile.filestatus, filetype: @quotationdatafile.filetype }
    assert_redirected_to quotationdatafile_path(assigns(:quotationdatafile))
  end

  test "should destroy quotationdatafile" do
    assert_difference('Quotationdatafile.count', -1) do
      delete :destroy, id: @quotationdatafile
    end

    assert_redirected_to quotationdatafiles_path
  end
end
