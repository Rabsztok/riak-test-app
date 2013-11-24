require 'test_helper'

class RiakAudiosControllerTest < ActionController::TestCase
  setup do
    @riak_audio = riak_audios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:riak_audios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create riak_audio" do
    assert_difference('RiakAudio.count') do
      post :create, riak_audio: { attachment: @riak_audio.attachment, name: @riak_audio.name }
    end

    assert_redirected_to riak_audio_path(assigns(:riak_audio))
  end

  test "should show riak_audio" do
    get :show, id: @riak_audio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @riak_audio
    assert_response :success
  end

  test "should update riak_audio" do
    put :update, id: @riak_audio, riak_audio: { attachment: @riak_audio.attachment, name: @riak_audio.name }
    assert_redirected_to riak_audio_path(assigns(:riak_audio))
  end

  test "should destroy riak_audio" do
    assert_difference('RiakAudio.count', -1) do
      delete :destroy, id: @riak_audio
    end

    assert_redirected_to riak_audios_path
  end
end
