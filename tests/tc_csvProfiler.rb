#!/home/tom/.rvm/rubies/ruby-1.9.3-p374/bin/ruby

require 'test/unit'
require '../lib/csv_profiler.rb'

class TestCsvProfiler < Test::Unit::TestCase

	def setup
		@cp = CsvProfiler.new("/home/tom/ruby/ppms-november-with-columns.csv")
	end
	
	def test_return_is_hash
		assert_instance_of( Hash, @cp.profile )
	end
	
	def test_return_hash_has_some_values
		assert_block("the returned hash has no values (zero length)") {
			true if @cp.profile.length > 0
		}
	end
	
	def test_return_hash_has_required_keys
		assert_block("the returned hash is missing some or all required keys") {
			if @cp.profile.has_key?("lines") && 
			@cp.profile.has_key?("minCols") && 
			@cp.profile.has_key?("maxCols") && 
			@cp.profile.has_key?("empties")
				true
			else
				false
			end
		}
	end

	def test_return_hash_values_are_numeric
		assert_block("the returned values are not numeric") {
			#allTrue = true
			@cp.profile.each_value do |each|
				#
			end
		}
	end


end
