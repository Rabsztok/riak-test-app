require 'test_helper'

class MongodbAudiosControllerTest < ActionController::TestCase
  setup do
    @mongodb_audio = mongodb_audios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mongodb_audios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mongodb_audio" do
    assert_difference('MongodbAudio.count') do
      post :create, mongodb_audio: { attachment: @mongodb_audio.attachment, name: @mongodb_audio.name }
    end

    assert_redirected_to mongodb_audio_path(assigns(:mongodb_audio))
  end

  test "should show mongodb_audio" do
    get :show, id: @mongodb_audio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mongodb_audio
    assert_response :success
  end

  test "should update mongodb_audio" do
    put :update, id: @mongodb_audio, mongodb_audio: { attachment: @mongodb_audio.attachment, name: @mongodb_audio.name }
    assert_redirected_to mongodb_audio_path(assigns(:mongodb_audio))
  end

  test "should destroy mongodb_audio" do
    assert_difference('MongodbAudio.count', -1) do
      delete :destroy, id: @mongodb_audio
    end

    assert_redirected_to mongodb_audios_path
  end
end
