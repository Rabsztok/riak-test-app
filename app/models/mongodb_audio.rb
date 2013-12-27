class MongodbAudio < ActiveRecord::Base
  include Generator

  attr_accessible :name, :attachment

  mount_uploader :attachment, MongodbAudioUploader

  def self.slug
    'mongodb'
  end
end
