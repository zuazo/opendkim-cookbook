# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
# Based on magic_shell cookbook code, thanks @sethvargo.

# More info at https://github.com/ruby/rake/blob/master/doc/rakefile.rdoc

require 'bundler/setup'

desc 'Generate Ruby documentation'
task :yard do
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.stats_options = %w(--list-undoc)
  end
end

task doc: %w(yard)

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task :style do
  next if ENV.key?('SKIP_STYLE_TESTS')
  task default: %w(style:chef style:ruby)
end

desc 'Run ChefSpec unit tests'
task :unit do
  next if ENV.key?('SKIP_UNIT_TESTS')
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format progress'
  end
end

namespace :integration do
  next if ENV.key?('SKIP_INTEGRATION_TESTS')

  def run_kitchen
    sh "kitchen test #{ENV['KITCHEN_ARGS']} #{ENV['KITCHEN_PLATFORM']}"
  end

  desc 'Run Test Kitchen integration tests using vagrant'
  task :vagrant do
    ENV.delete('KITCHEN_LOCAL_YAML')
    run_kitchen
  end

  desc 'Run Test Kitchen integration tests using docker'
  task :docker do
    ENV['KITCHEN_LOCAL_YAML'] = '.kitchen.docker.yml'
    run_kitchen
  end
end

task integration: %w(integration:default)

namespace :travis do
  desc 'Run tests on Travis'
  task ci: %w(style unit integration:docker)
end

task default: %w(doc style unit integration:vagrant)
