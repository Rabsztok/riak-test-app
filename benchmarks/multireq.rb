require 'net/http'

max_threads = 10

uri = URI(ARGV[0])

threads_tab = []
0.upto(max_threads).each { |i| threads_tab << 2**i}

threads_tab.each { |thr|
	puts "#{thr}"
	File.open("../log/active_record.log", "a+") do |file|
		file.puts "#{thr}"
	end
	10.times {
  	time = Time.now
		thr.times.map {
	  	Thread.new { Net::HTTP.get_response(uri) }
		}.each(&:join)
		puts Time.now - time
  }
}
