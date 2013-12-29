# Generates curl requests for testing purposes
class CurlWorker
  include Sidekiq::Worker

  def perform(address, n = 10)
    n.to_i.times { Curl.get(address) }
  end

end
