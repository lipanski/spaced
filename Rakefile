# frozen_string_literal: true

require_relative "config/application"

Rails.application.load_tasks

task default: "test:all"

namespace :test do
  desc "Run all tests"
  task all: ["test", "test:system", "test:rubocop"] do; end

  desc "Run rubocop checks"
  task :rubocop do
    require "rubocop/rake_task"
    RuboCop::RakeTask.new
  end
end
