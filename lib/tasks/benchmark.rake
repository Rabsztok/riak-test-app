namespace :benchmark do
  task :run, [:ip, :class_name, :max_threads, :audio_count] => [:environment] do |t, args|
    model = args.class_name.constantize
    ids = (100..500).to_a
    max_threads = Integer(args.max_threads)
    audio_count = Integer(args.audio_count)

    thread_repeats = (1..max_threads).map { |t| 2 ** t }

    thread_repeats.map do |repeats|
      results = []
      audio_count.times do |i|
        start = Time.now
        repeats.times do
          url = "http://#{args.ip}/audios/#{model.model_name.plural.slice(0..-8)}/#{ids.sample}/download"
          Thread.new { Net::HTTP.get_response(URI(url)) }
        end
        results << Time.now - start
      end
      puts (results.sum).round(3).to_s.sub('.',',')
    end
  end
end
