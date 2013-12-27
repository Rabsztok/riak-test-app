class MysqlAudiosController < ApplicationController
  # GET /mysql_audios
  # GET /mysql_audios.json
  def index
    @mysql_audios = MysqlAudio.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mysql_audios }
    end
  end

  # GET /mysql_audios/1
  # GET /mysql_audios/1.json
  def show
    @mysql_audio = MysqlAudio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mysql_audio }
    end
  end

  # GET /mysql_audios/1/download
  def download
    @mysql_audio = MysqlAudio.find(params[:id])
    content = @mysql_audio.attachment.read
    if stale?(etag: content, last_modified: @mysql_audio.updated_at.utc, public: true)
      send_data content, type: @mysql_audio.attachment.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  # GET /mysql_audios/new
  # GET /mysql_audios/new.json
  def new
    @mysql_audio = MysqlAudio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mysql_audio }
    end
  end

  # GET /mysql_audios/1/edit
  def edit
    @mysql_audio = MysqlAudio.find(params[:id])
  end

  # POST /mysql_audios
  # POST /mysql_audios.json
  def create
    @mysql_audio = MysqlAudio.new(params[:mysql_audio])

    respond_to do |format|
      if @mysql_audio.save
        format.html { redirect_to @mysql_audio, notice: 'Mysql audio was successfully created.' }
        format.json { render json: @mysql_audio, status: :created, location: @mysql_audio }
      else
        format.html { render action: "new" }
        format.json { render json: @mysql_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mysql_audios/1
  # PUT /mysql_audios/1.json
  def update
    @mysql_audio = MysqlAudio.find(params[:id])

    respond_to do |format|
      if @mysql_audio.update_attributes(params[:mysql_audio])
        format.html { redirect_to @mysql_audio, notice: 'Mysql audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mysql_audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mysql_audios/1
  # DELETE /mysql_audios/1.json
  def destroy
    @mysql_audio = MysqlAudio.find(params[:id])
    @mysql_audio.destroy

    respond_to do |format|
      format.html { redirect_to mysql_audios_url }
      format.json { head :no_content }
    end
  end
end
