#!/usr/bin/env ruby

require 'test/unit'
require 'csv_profiler'

class TestCsvProfiler < Test::Unit::TestCase

	def setup
		@cp = CsvProfiler.new("tests/fixtures/ppms-november-with-columns-10000.csv")
		@profile = @cp.profile
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


#	def test_find_cell_value_type_float_0
#		value = "0"
#		assert(@cp.find_cell_value_type(value) == :numeric, "float 0: " + value.to_s + " was not a float")
#	end

#	def test_find_cell_value_type_float_1
#		value = "0.623"
#		assert(@cp.find_cell_value_type(value) == :numeric, "float 1: " + value.to_s + " was not a float")
#	end

	def test_find_cell_value_type_float_2
		value = "-1.23"
		assert(@cp.find_cell_value_type(value) == :numeric, "float 2: " + value.to_s + " was not a float")
	end

#	def test_find_cell_value_type_datetime_0
#		assert(@cp.find_cell_value_type("13/11/2012 00:00") == :datetime, "test value was not a datetime")
#	end

	def test_find_cell_value_type_datetime_1
		assert(@cp.find_cell_value_type("SW14 8SR") == :datetime, "test value was not a datetime")
	end


	def test_find_cell_value_type_string_0
		value = "hello"
		assert(@cp.find_cell_value_type(value) == :string, value + " was not a string")
	end

	def test_find_cell_value_type_string_1
		value = "3 is the magic number"
		assert(@cp.find_cell_value_type(value) == :string, value + " was not a string")
	end

	def test_find_cell_value_type_string_2
		value = "123-124"
		assert(@cp.find_cell_value_type(value) == :string, value + " was not a string")
	end

	def test_find_cell_value_type_string_3
		value = "--123"
		assert(@cp.find_cell_value_type(value) == :string, value + " was not a string")
	end

end
