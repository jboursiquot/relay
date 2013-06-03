require 'rake/testtask'
require 'yard'

task :default => [:test]

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['app.rb', '**/helpers/*.rb', '**/routes/*.rb', '**/models/*.rb']
  t.options = ['--protected', '--private']
end
