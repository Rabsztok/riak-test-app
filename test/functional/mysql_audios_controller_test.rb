require 'test_helper'

class MysqlAudiosControllerTest < ActionController::TestCase
  setup do
    @mysql_audio = mysql_audios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mysql_audios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mysql_audio" do
    assert_difference('MysqlAudio.count') do
      post :create, mysql_audio: { attachment: @mysql_audio.attachment, name: @mysql_audio.name }
    end

    assert_redirected_to mysql_audio_path(assigns(:mysql_audio))
  end

  test "should show mysql_audio" do
    get :show, id: @mysql_audio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mysql_audio
    assert_response :success
  end

  test "should update mysql_audio" do
    put :update, id: @mysql_audio, mysql_audio: { attachment: @mysql_audio.attachment, name: @mysql_audio.name }
    assert_redirected_to mysql_audio_path(assigns(:mysql_audio))
  end

  test "should destroy mysql_audio" do
    assert_difference('MysqlAudio.count', -1) do
      delete :destroy, id: @mysql_audio
    end

    assert_redirected_to mysql_audios_path
  end
end
