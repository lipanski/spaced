# frozen_string_literal: true

require_relative "config/application"

Rails.application.load_tasks

task default: [:rubocop, :database_consistency, :test]

desc "Run rubocop"
task :rubocop do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end

desc "Run database_consistency"
task :database_consistency do
  require "database_consistency"
  result = DatabaseConsistency.run
  exit(result)
end
