require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
	t.libs << "tests"
	t.libs << "lib"
	t.test_files = FileList['./tests/tc_*.rb']
	t.verbose = true
end
