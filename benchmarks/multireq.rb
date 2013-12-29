require 'net/http'

samp = ARGV[1].to_i
thr = ARGV[2].to_i
uri = URI(ARGV[0])

print "\n"
puts ARGV[0]

samp.times {
  thr.times.map {
    Thread.new { Net::HTTP.get_response(uri) }
  }.each(&:join)
}