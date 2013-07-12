class CsvProfiler

	require 'date'
	require 'digest/md5'

	def initialize(file)
		@file = file
		@lines = 0
		@minCols = nil
		@maxCols = nil
		@empties = 0
		@chars = {}
		@column_files = {}
		@column_data_path = "/tmp/csv-profiler/"
		@column_data_dir = setup_data_directory()
		@stats = {}
		read_file
		profile_columns
	end

	def get_stats
		@stats
	end

	def setup_data_directory
		if !Dir.exists?(@column_data_path)
			Dir.mkdir(@column_data_path)
		end
		Dir.open(@column_data_path)
	end

	def read_file
		File.open(@file) do |file|
			file.each_line do |line|
				@lines += 1
				process_line(line)
			end
		end
		@stats.merge!({
			"lines" => @lines,
			"minCols" => @minCols,
			"maxCols" => @maxCols,
			"empties" => @empties
		})
	end


	def process_line(line)
		cols = line.split ","
		@minCols = cols.length if @minCols.nil? || cols.length < @minCols
		@maxCols = cols.length if @maxCols.nil? || cols.length > @maxCols
		i = 0
		cols.each do |each|
			cell_content=cleanup_cell(each)
			@empties += 1 if cell_content.empty?
			append_to_column(i,cell_content)
			i += 1
		end
	end


	def cleanup_cell(cell_content)
		cell_content.gsub! '"', '' if cell_content[0] == '"' || cell_content[-1] == '"'
		cell_content.strip
	end


	def append_to_column(column_no,cell_content)
		if @column_files.has_key?(column_no)
			target_file = @column_files[column_no]
		else
			target_file = @column_data_path + 'col-' + Digest::MD5.hexdigest(@file) + '-' + Time.new.to_i.to_s + '-' + column_no.to_s
			@column_files[column_no] = target_file
		end
		File.open(target_file, "a").write(cell_content + "\n").to_s
	end

	def profile_columns
		@column_files.each do |key,value|
			#puts "#{key} is #{value}"
		end
	end


end
