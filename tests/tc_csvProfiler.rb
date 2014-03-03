#!/usr/bin/env ruby

require 'test/unit'
require 'csv_profiler'

class TestCsvProfiler < Test::Unit::TestCase

	def setup
		@cp = CsvProfiler.new("tests/fixtures/ppms-november-with-columns-10000.csv")
		@profile = @cp.get_stats
	end

	def test_output_cleanup_cell
		dirty = '" foo bar "'
		clean = 'foo bar'
		assert_block('line not properly cleaned') {
			true if @cp.cleanup_cell(dirty) == clean
		}
	end
	
	def test_return_is_hash
		assert_instance_of( Hash, @profile )
	end
	
	def test_return_hash_has_some_values
		assert_block("the returned hash has no values (zero length)") {
			true if @profile.length > 0
		}
	end
	
	def test_return_hash_has_required_keys
		assert_block("the returned hash is missing some or all required keys") {
			@profile.has_key?("lines") && 
			@profile.has_key?("minCols") && 
			@profile.has_key?("maxCols") && 
			@profile.has_key?("empties")
		}
	end

	def test_return_hash_key_are_strings
		assert(@profile.keys.all? { |key| key.is_a? String }, "not all hash keys are strings")
	end

	def test_return_hash_values_are_integers
		assert(@profile.values.all? { |value| value.is_a? Integer }, "not all hash values are integers")
	end


end
