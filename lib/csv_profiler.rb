class CsvProfiler

	require 'date'

	def initialize(file)
		@file = file
		@lines = 0
		@minCols = nil
		@maxCols = nil
		@empties = 0
		#@numerics = 0
		#@strings = 0
		#@dates = 0
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
			#else
			#	case find_cell_value_type(each)
			#	when :numeric
			#		@numerics += 1
			#	when :string
			#		@strings += 1
			#	end
			end
		end
	end
	

end