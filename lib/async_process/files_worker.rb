module AsyncProcess  
	class FilesWorker
		def initialize( scanner )
			@scanner = scanner
		end

		def process_folder(folder, &block)
			@scanner.files_for_folder( folder ) do |file|
        block.call_event :file_in_folder, file, folder
			end
      block.call_event :folder_end, folder
		end
	end
end
