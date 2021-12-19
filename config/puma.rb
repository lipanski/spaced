# frozen_string_literal: true

max_threads_count = ENV.fetch("SPACED_THREADS", 5)
min_threads_count = ENV.fetch("SPACED_THREADS") { max_threads_count }

threads(min_threads_count, max_threads_count)
port(ENV.fetch("SPACED_SERVER_PORT", 3000))
environment(ENV.fetch("RAILS_ENV", "development"))

plugin(:tmp_restart)
