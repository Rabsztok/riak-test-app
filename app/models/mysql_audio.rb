class MysqlAudio < ActiveRecord::Base
  include Generator

  attr_accessible :name, :attachment

  mount_uploader :attachment, MysqlAudioUploader

  def self.slug
    'mysql'
  end
end
