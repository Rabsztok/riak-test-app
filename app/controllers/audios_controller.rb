class AudiosController < ApplicationController
  before_filter :model

  def index
    @audios = model.page(params[:page]).per(20)

    respond_to do |format|
      format.html
      format.json { render json: @audios }
    end
  end

  def new
    AudioWorker.perform_async(model.slug)

    redirect_to audios_path(model.slug), notice: 'New audio file is being generated...'
  end

  def download
    start = Time.new
    @audio = model.find(params[:id])
    content = @audio.attachment.read
    if stale?(etag: content, last_modified: @audio.updated_at.utc, public: true)
      send_data content, type: "audio/x-wav", disposition: "inline"
      expires_in 0, public: true
    end
    logger.tagged("Benchmark-#{@audio.class}") { logger.info Time.now - start }
  end

  def name
    render text: model.find(params[:id]).text
  end

  def destroy
    @audio = model.find(params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to audios_url }
      format.json { head :no_content }
    end
  end

  private

  def model
    @model ||= case params[:model]
      when 'riak' then RiakAudio
      when 'mongodb' then MongodbAudio
      else MysqlAudio
    end
  end
end
