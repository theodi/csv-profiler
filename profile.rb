#!/home/tom/.rvm/rubies/ruby-1.9.3-p374/bin/ruby

require './lib/csv_profiler.rb'

csv = '/home/tom/ruby/ppms-november-with-columns.csv'
p = CsvProfiler.new(csv)
p.profile
#puts p.class.instance_methods(false)
