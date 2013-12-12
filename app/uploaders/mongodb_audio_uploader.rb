class MongodbAudioUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :grid_fs
  process :set_content_type
end