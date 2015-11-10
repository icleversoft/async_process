module AsyncProcess  
	class FilesWorker
		def initialize( scanner, on_file_process = nil, on_process_end = nil )
			@scanner = scanner
			@on_process = on_file_process
			@on_end = on_process_end
		end

		def process_folder(folder)
			@scanner.files_for_folder( folder ) do |file|
				@on_process.call( file  ) if @on_process
			end
			@on_end.call if @on_end
		end
	end
end
