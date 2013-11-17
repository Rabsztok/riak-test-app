# Generates sample audio for testing purposes
class AudioWorker
  include Sidekiq::Worker

  def perform
    file = Tempfile.new ["audio", ".wav"]
    generator = case Random.rand(3)
      when 0 then Faker::SamuelLIpsum.new
      when 1 then Faker::MetalIpsum.new
      else Faker::BaconIpsum.new
    end
    lyrics = ""
    10.times do
      lyrics << generator.paragraph
    end
    %x[ echo "#{lyrics}" | espeak --stdin -s 120 --stdout > #{file.path}]
    RiakAudio.create name: Forgery(:name).company_name, attachment: file
  end
end
