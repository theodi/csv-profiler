class CsvProfiler

	require 'date'

	def initialize(file)
		@file = file
		@lines = 0
		@minCols = nil
		@maxCols = nil
		@empties = 0
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
			@empties += 1 if each.empty?
		end
	end
	

end