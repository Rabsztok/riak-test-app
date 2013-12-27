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
    @audio = model.generate

    redirect_to audios_path(model.slug), notify: 'New audio file generated'
  end

  def download
    @audio = model.find(params[:id])
    content = @audio.attachment.read
    if stale?(etag: content, last_modified: @audio.updated_at.utc, public: true)
      send_data content, type: "audio/x-wav", disposition: "inline"
      expires_in 0, public: true
    end
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
