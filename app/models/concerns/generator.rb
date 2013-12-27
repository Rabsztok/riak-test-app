module Generator
  extend ActiveSupport::Concern

  included do
    def self.generate(length = 7)
      generator = case Random.rand(3)
        when 0 then Faker::SamuelLIpsum.new
        when 1 then Faker::MetalIpsum.new
        else Faker::BaconIpsum.new
      end
      lyrics = ""
      length.times { lyrics << generator.paragraph }

      file = Tempfile.new ["audio", ".wav"]
      %x[ echo "#{lyrics}" | espeak --stdin -s 120 --stdout > #{file.path}]

      create name: Forgery(:name).company_name, attachment: file
    ensure
      file.close
      file.unlink
    end
  end
end