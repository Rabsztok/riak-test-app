class MongodbAudio < ActiveRecord::Base
  attr_accessible :name, :attachment

  mount_uploader :attachment, MongodbAudioUploader
end
