class RiakAudiosController < ApplicationController

  def index
    @riak_audios = RiakAudio.page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.json { render json: @riak_audios }
    end
  end

  def show
    @riak_audio = RiakAudio.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @riak_audio }
    end
  end

  def new
    @riak_audio = RiakAudio.new

    respond_to do |format|
      format.html
      format.json { render json: @riak_audio }
    end
  end

  def edit
    @riak_audio = RiakAudio.find(params[:id])
  end

  def download
    @riak_audio = RiakAudio.find(params[:id])
    content = @riak_audio.attachment.read
    if stale?(etag: content, last_modified: @riak_audio.updated_at.utc, public: true)
      send_data content, type: @riak_audio.attachment.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def create
    @riak_audio = RiakAudio.new(params[:riak_audio])

    respond_to do |format|
      if @riak_audio.save
        format.html { redirect_to @riak_audio, notice: 'Riak audio was successfully created.' }
        format.json { render json: @riak_audio, status: :created, location: @riak_audio }
      else
        format.html { render action: "new" }
        format.json { render json: @riak_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @riak_audio = RiakAudio.find(params[:id])

    respond_to do |format|
      if @riak_audio.update_attributes(params[:riak_audio])
        format.html { redirect_to @riak_audio, notice: 'Riak audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @riak_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @riak_audio = RiakAudio.find(params[:id])
    @riak_audio.destroy

    respond_to do |format|
      format.html { redirect_to riak_audios_url }
      format.json { head :no_content }
    end
  end
end
