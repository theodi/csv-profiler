class CsvProfiler

	require 'date'

	def initialize(file)
		@file = file
		@lines = 0
		@minCols = nil
		@maxCols = nil
		@empties = 0
		@numerics = 0
		@strings = 0
		@dates = 0
	end
	
	def profile
		File.open(@file) do |file|
			file.each_line do |line|
				@lines += 1
				process_line(line)
			end
		end
		{
			"lines" => @lines,
			"minCols" => @minCols,
			"maxCols" => @maxCols,
			"empties" => @empties
		}
	end


	def process_line(line)
		cols = line.split ","
		@minCols = cols.length if @minCols.nil? || cols.length < @minCols
		@maxCols = cols.length if @maxCols.nil? || cols.length > @maxCols
		cols.each do |each|
			# cleanup quotes and whitespace
			each.gsub! '"', '' if each[0] == '"' || each[-1] == '"'
			each.strip!
			# check whether each cell is empty
			if each.empty?
				@empties += 1
			else
				case find_cell_value_type(each)
				when :numeric
					@numerics += 1
				when :string
					@strings += 1
				end
			end
		end
	end

	# value should be of type String
	def find_cell_value_type(value)

		# catch obvious strings
		if value.match(/[^0-9eE\-\.,]+/)	# match any string that doesn't include 0-9eE-., (i.e. non-digits that might be classed as valid in a string representations of a number.	# value.match(/[a-zA-Z[^eE]\s\/]+/)
			#puts value
			is_string_or_datetime(value)
		else
			#puts value + ' (probably numeric)'
			:numeric
		end

		# catch obvious strings
		#if value.match(/[a-df-zA-DF-Z\s]+/) || value.match(/^[.^\-]+[\-]+/)
		#	is_string_or_datetime(value)
		#else

		#if value.match(/'0'+[\.]?'0'+/)
		#	puts value + ' (numeric)'
		#	:numeric
		#else 
		#	if value.to_i === 0 || value.to_f === 0.0 
		#		is_string_or_datetime(value)
		#	else
		#		rational = eval(value.to_r.to_s)
		#		case rational
		#		when 0
		#			puts value + ' (string)'
		#			is_string_or_datetime(value)
		#		else
		#			puts rational.to_s + ' (numeric)'
		#		end
		#	end
		#end

				
			#	if value.to_i === 0 || value.to_f === 0.0
			#		is_string_or_datetime(value)
			#	else
			#
			#		begin
			#			Fixnum(value)
			#			:numeric
			#		rescue ArgumentError
			#			# catch number ranges and numerical expressions which to_r may try to evaluate <-- still necessary
			#			# add other things here like ^ and e ?
			#			if value.match(/[\-\+]?[\-\+\*\/]+/)
			#				is_string_or_datetime(value)
			#			else
			#				#puts "--------" + value + " (numeric)"
			#				:numeric
			#			end
			#		end
			#	end
			#end
		#end

	end




	def is_string_or_datetime(value)
		#if match.value(/[a-zA-Z[^T]]+/)		#
		#	puts "--------" + value + " (string)"
		#	:string
		#else
			begin
				DateTime.parse(value)
				type = :datetime
			rescue ArgumentError, RangeError
				type = :string
			end
			case type
			when :string
				#puts "--------" + value + " (string)"
				type
			when :datetime
				#puts "--------" + value + " (datetime)"
				type
			end
		#end
	end

	

end