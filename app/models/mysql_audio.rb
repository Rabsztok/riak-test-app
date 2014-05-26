class MysqlAudio < ActiveRecord::Base
  include Generator

  mount_uploader :attachment, MysqlAudioUploader

  def self.slug
    'mysql'
  end
end
