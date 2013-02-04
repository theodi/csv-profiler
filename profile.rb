#!/usr/bin/env ruby

require './lib/csv_profiler'

csv = './tests/fixtures/ppms-november-with-columns-10000.csv'
p = CsvProfiler.new(csv)

# profile the input file
results = p.profile
results.each do | key, value |
	puts key + ': ' + value.to_s
end