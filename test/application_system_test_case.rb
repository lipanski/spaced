# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  parallelize(workers: 1)
  driven_by :selenium, using: ENV["BROWSER"].presence&.to_sym || :headless_chrome, screen_size: [1400, 1400]
end
