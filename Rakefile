#!/usr/bin/ruby
#
# Run several types of tests againsts a puppet repo (module or master
# config).
#
# author: Thomas Van Doren

require 'rake'

# default
desc 'Run all tests.'
task :default => ['check:syntax', 'check:lint', 'check:spec']

# help
desc 'Show available tasks and exit.'
task :help do
  system('rake -T')
end

# clean, clobber
require 'rake/clean'
CLEAN.include('doc')
CLOBBER.include('')

namespace :check do
  # syntax
  desc 'Validate syntax for all manifests.'
  task :syntax do
    successes = []
    failures = []
    Dir.glob('**/*.pp').each do |puppet_file|
      puts "Checking syntax for #{puppet_file}"

      # Run syntax checker in subprocess.
      system("puppet parser validate #{puppet_file}")

      # Keep track of the results.
      if $?.success?
        successes << puppet_file
      else
        failures << puppet_file
      end
    end

    # Print the results.
    total_manifests = successes.count + failures.count
    puts "#{total_manifests} files total."
    puts "#{successes.count} files succeeded."
    puts "#{failures.count} files failed:"
    puts
    failures.each do |filename|
      puts filename
    end

    # Fail the task if any files failed syntax check.
    if failures.count > 0
      fail("#{failures.count} filed failed syntax check.")
    end
  end

  # lint
  require 'puppet-lint/tasks/puppet-lint'

  # spec
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*/*_spec.rb'
  end
end

# doc
desc 'Build rdoc documentation.'
task :doc do
  cwd = Dir.pwd
  manifest_dir = "#{cwd}/manifests"
  module_path = "#{cwd}/modules"
  system("puppet doc --mode rdoc --manifestdir #{manifest_dir} --modulepath #{module_path}")
end
