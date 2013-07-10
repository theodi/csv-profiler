class CsvProfiler

	require 'date'

	def initialize(file)
		@file = file
		@lines = 0
		@minCols = nil
		@maxCols = nil
		@empties = 0
		@chars = {}
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
		i = 0
		cols.each do |each|
			cell=cleanup_cell(each)
			@empties += 1 if cell.empty?
			i += 1
		end
	end


	def cleanup_cell(cell)
			cell.gsub! '"', '' if cell[0] == '"' || cell[-1] == '"'
			cell.strip
	end

end
