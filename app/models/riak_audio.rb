class RiakAudio < ActiveRecord::Base
  include Generator

  attr_accessible :name, :attachment

  mount_uploader :attachment, RiakAudioUploader

  def self.slug
    'riak'
  end
end
