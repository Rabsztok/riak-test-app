class MongodbAudiosController < ApplicationController
  # GET /mongodb_audios
  # GET /mongodb_audios.json
  def index
    @mongodb_audios = MongodbAudio.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mongodb_audios }
    end
  end

  # GET /mongodb_audios/1
  # GET /mongodb_audios/1.json
  def show
    @mongodb_audio = MongodbAudio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mongodb_audio }
    end
  end

  # GET /mongodb_audios/1/download
  def download
    @mongodb_audio = MongodbAudio.find(params[:id])
    content = @mongodb_audio.attachment.read
    if stale?(etag: content, last_modified: @mongodb_audio.updated_at.utc, public: true)
      send_data content, type: @mongodb_audio.attachment.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  # GET /mongodb_audios/new
  # GET /mongodb_audios/new.json
  def new
    @mongodb_audio = MongodbAudio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mongodb_audio }
    end
  end

  # GET /mongodb_audios/1/edit
  def edit
    @mongodb_audio = MongodbAudio.find(params[:id])
  end

  # POST /mongodb_audios
  # POST /mongodb_audios.json
  def create
    @mongodb_audio = MongodbAudio.new(params[:mongodb_audio])

    respond_to do |format|
      if @mongodb_audio.save
        format.html { redirect_to @mongodb_audio, notice: 'Mongodb audio was successfully created.' }
        format.json { render json: @mongodb_audio, status: :created, location: @mongodb_audio }
      else
        format.html { render action: "new" }
        format.json { render json: @mongodb_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mongodb_audios/1
  # PUT /mongodb_audios/1.json
  def update
    @mongodb_audio = MongodbAudio.find(params[:id])

    respond_to do |format|
      if @mongodb_audio.update_attributes(params[:mongodb_audio])
        format.html { redirect_to @mongodb_audio, notice: 'Mongodb audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mongodb_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mongodb_audios/1
  # DELETE /mongodb_audios/1.json
  def destroy
    @mongodb_audio = MongodbAudio.find(params[:id])
    @mongodb_audio.destroy

    respond_to do |format|
      format.html { redirect_to mongodb_audios_url }
      format.json { head :no_content }
    end
  end
end
