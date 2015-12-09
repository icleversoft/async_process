module AsyncProcess  
	class FilesWorker < Worker
    attr_reader :items
		def initialize( items = [], options = {})
			@scanner = options[:scanner] 
      raise ArgumentError.new("You should pass a FileScanner") unless @scanner
      super( @scanner.folders )
		end

		def process(item, &block)
			@scanner.files_for_folder( item ) do |file|
        block.call_event :process_item, file, item 
			end
      block.call_event :collection_end, item 
		end
	end
end
