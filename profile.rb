#!/usr/bin/env ruby

require './lib/csv_profiler'

csv = '/home/tom/ruby/ppms-november-with-columns.csv'
p = CsvProfiler.new(csv)
p.profile
