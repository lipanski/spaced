# frozen_string_literal: true

require_relative "config/application"
require "rubocop/rake_task"

Rails.application.load_tasks

task default: [:rubocop, :test]

desc "Run rubocop"
task :rubocop do
  RuboCop::RakeTask.new
end
