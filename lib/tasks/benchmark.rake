namespace :benchmark do
  task :run, [:class_name, :max_threads, :audio_count] => [:environment] do |t, args|
    model = args.class_name.constantize
    ids = model.scoped.pluck(:id)
    max_threads = Integer(args.max_threads)
    audio_count = Integer(args.audio_count)

    thread_repeats = (1..max_threads).map { |t| t ** 2 }

    thread_repeats.each do |repeats|
      puts repeats
      Benchmark.bm do |bm|
        audio_count.times do
          bm.report do
            repeats.times do
              url = "http://riak/audios/#{model.model_name.plural.slice(0..-8)}/#{ids.sample}/download"
              Thread.new { Net::HTTP.get_response(URI(url)) }
            end
          end
        end
      end
    end
  end
end
