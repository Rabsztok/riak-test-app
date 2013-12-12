class MysqlAudioUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :file
  process :set_content_type
end