class MongodbAudio < ActiveRecord::Base
  include Generator

  mount_uploader :attachment, MongodbAudioUploader

  def self.slug
    'mongodb'
  end
end
