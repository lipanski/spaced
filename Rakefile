# frozen_string_literal: true

require_relative "config/application"

Rails.application.load_tasks

task default: ["test", "test:system", "rubocop"]

desc "Run rubocop checks"
task :rubocop do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end
