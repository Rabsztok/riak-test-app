class RiakAudio < ActiveRecord::Base
  include Generator

  mount_uploader :attachment, RiakAudioUploader

  def self.slug
    'riak'
  end
end
