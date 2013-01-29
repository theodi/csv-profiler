class CsvProfiler

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
				self.processLine(line)
			end
		end
		results = {
			"lines" => @lines,
			"minCols" => @minCols,
			"maxCols" => @maxCols,
			"empties" => @empties
		}
		results
	end


	def processLine(line)
		cols = line.split ","
		@minCols = cols.length if @minCols.nil? || cols.length < @minCols
		@maxCols = cols.length if @maxCols.nil? || cols.length > @maxCols
		cols.each do |each|
			# check whether each cell is empty
			each.gsub! '"', '' if each[0] == '"' || each[-1] == '"'
			each.strip!
			# 
			if each.empty?
				@empties += 1
			else
				self.findCellValueType(each)
			end
		end
	end
	
	
	def findCellValueType(value)
		#Float(each) raise ArgumentError rescue @numerics += 1

		
		begin
			Float(value)
			puts value + ' is float'	
		rescue ArgumentError
			puts value + 'is not float'
		end
		
		# work out the type of each cell value
		#rescue ArgumentError
		#rescue OneTypeOfException
	end


	#private :processLine


end
