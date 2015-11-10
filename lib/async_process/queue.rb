module AsyncProcess
  class Queue
    CONCURRENT_WORKERS = 3
    attr_reader :scanner
    def initialize( scanner, on_file_process = nil, on_queue_end = nil  )
      @scanner = scanner
      @folders = scanner.folders
      @workers = []
      @on_file_process = on_file_process
      @on_queue_end = on_queue_end
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

    def process
      fork do
        while folder = @folders.pop
          if @workers.size < workers_count 
          @workers << FilesWorker.new(@scanner, on_file, on_end).process_folder(folder)
          end
        end
        @on_queue_end.call if @on_queue_end
      end

    end

    private
    def on_file
      lambda do |file|
        @on_file_process.call(file) if @on_file_process
      end
    end

    def on_end
      lambda do
        @workers.pop
      end
    end
  end
end
