class MysqlAudioUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :file
  process :set_content_type

  def store_dir
    'system/uploads'
  end
end