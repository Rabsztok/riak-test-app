# Generates sample audio for testing purposes
class AudioWorker
  include Sidekiq::Worker

  def perform
    generator = case Random.rand(3)
      when 0 then Faker::SamuelLIpsum.new
      when 1 then Faker::MetalIpsum.new
      else Faker::BaconIpsum.new
    end
    lyrics = ""
    7.times do
      lyrics << generator.paragraph
    end
    file = Tempfile.new ["audio", ".wav"]
    %x[ echo "#{lyrics}" | espeak --stdin -s 120 --stdout > #{file.path}]
    MysqlAudio.create name: Forgery(:name).company_name, attachment: file
    RiakAudio.create name: Forgery(:name).company_name, attachment: file
    MongodbAudio.create name: Forgery(:name).company_name, attachment: file
  ensure
    file.close
    file.unlink
  end
end
