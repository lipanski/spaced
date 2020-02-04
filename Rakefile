# frozen_string_literal: true

require_relative "config/application"

Rails.application.load_tasks

task default: [:rubocop, :test]

desc "Run rubocop"
task :rubocop do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end
