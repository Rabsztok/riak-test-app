class RiakAudioUploader < CarrierWave::Uploader::Riak
  include CarrierWave::MimeTypes

  process :set_content_type

  def key
    original_filename
  end

  def bucket
    "audios"
  end
end