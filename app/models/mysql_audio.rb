class MysqlAudio < ActiveRecord::Base
  attr_accessible :name, :attachment

  mount_uploader :attachment, MysqlAudioUploader
end
