require "appraisal"
require "bundler"
require "rspec/core/rake_task"

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec)

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task :default do
    sh "appraisal install && rake appraisal spec"
  end
else
  task default: [:spec]
end
