namespace :benchmark do
  task :run, [:ip, :class_name, :max_threads, :audio_count] => [:environment] do |t, args|
    model = args.class_name.constantize
    ids = (100..500).to_a
    max_threads = Integer(args.max_threads)
    audio_count = Integer(args.audio_count)
    hydra = Typhoeus::Hydra.new(max_concurrency: max_threads)
    
    responses = []
    audio_count.times do |i|
      url = "http://#{args.ip}/audios/#{model.model_name.plural.slice(0..-8)}/#{ids.sample}/download"
      responses << hydra.queue(Typhoeus::Request.new(url))
    end
    puts Benchmark.measure { hydra.run }
  end
end
