# Generates sample audio for testing purposes
class AudioWorker
  include Sidekiq::Worker

  def perform(slug = nil)
    return [RiakAudio, MongodbAudio, MysqlAudio].each(&:generate) if slug.nil?
    model = case slug
      when 'riak' then RiakAudio
      when 'mongodb' then MongodbAudio
      when 'mysql' then MysqlAudio
    end
    model.generate
  end

end
