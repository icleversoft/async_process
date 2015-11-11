module AsyncProcess
  class Queue
    CONCURRENT_WORKERS = 3
    attr_reader :scanner
    def initialize( scanner )
      @scanner = scanner
      @folders = scanner.folders
      @workers = []
    end

    def size
      @folders.size
    end

    def workers_count
      @workers_count ||= CONCURRENT_WORKERS
    end

    def workers_count=( value )
      raise ArgumentError.new("Should be a value greater than 1!") if value.to_i <= 1
      @workers_count = value.to_i
    end

    def process(&block)
      raise LoadError.new("You should use a block") unless block
      fork do
        while folder = @folders.pop
          if @workers.size < workers_count 
            worker = FilesWorker.new(@scanner)
            @workers << worker
            worker.process_folder( folder ) do |on|
              on.file_in_folder do |file, folder|
                block.call_event :file_to_process, file
              end
              on.folder_end do |folder|
                @workers.pop
              end
            end
          end
        end
      end
        block.call_event :queue_end

    end

  end
end
