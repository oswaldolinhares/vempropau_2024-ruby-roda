environment ENV.fetch("RACK_ENV", "development")

port ENV.fetch("PORT", 9292)

threads_count = ENV.fetch("MAX_THREADS", 5).to_i
threads threads_count, threads_count
