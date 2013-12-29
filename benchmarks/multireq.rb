require 'net/http'

uri = URI(ARGV[0])

print "\n"

threads_tab = []
0.upto(10).each { |i| threads_tab << 2**i}

threads_tab.each { |thr|
	puts "Threads - #{thr}"
	10.times {
  	time = Time.now
		thr.times.map {
	  	Thread.new { Net::HTTP.get_response(uri) }
		}.each(&:join)
		puts Time.now - time
  }
	puts ""
}
