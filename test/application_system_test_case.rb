# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  parallelize(workers: 1)
  driven_by :selenium, using: ENV["HEADLESS"] ? :headless_firefox : :firefox, screen_size: [1400, 1400]
end
