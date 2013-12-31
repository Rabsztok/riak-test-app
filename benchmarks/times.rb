File.open(ARGV[0]) do |file|
  10.times do # k grup wątków
    puts threads = file.readline.to_i
    all_trials = []
    10.times do |trial| # 10 prób
      tmp_threads = []
      threads.times do |index| # n wątków
        line = file.readline
        time = /(\(.*\))/.match(line)[1][1 .. -4]
        # puts time
        tmp_threads[index] = time
      end
      all_trials[trial] = tmp_threads
    end
    all_trials.transpose.each { |line| puts (line.map(&:to_f).inject(:+) /line.size.to_f).round(2) }
  end
end