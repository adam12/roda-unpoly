require "rake/testtask"
require "rubygems/tasks"
require "standard/rake"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/test*.rb"]
  t.verbose = true
end

Gem::Tasks.new

task default: :test
