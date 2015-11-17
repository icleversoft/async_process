module AsyncProcess  
	class FilesWorker
    attr_reader :items
		def initialize( scanner )
			@scanner = scanner
      @items = @scanner.folders
		end

		def process(item, &block)
			@scanner.files_for_folder( item ) do |file|
        block.call_event :process_item, file, item 
			end
      block.call_event :collection_end, item 
		end
	end
end
