require 'parallel'
module AsyncProcess
  class Queue
    CONCURRENT_WORKERS = 3
    attr_reader :scanner, :processed_files, :files_count
    def initialize( scanner )
      @scanner = scanner
      @folders = scanner.folders
      @processed_files = 0
      @files_count = scanner.files_count
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
      Runner.from_worker(FilesWorker.new(@scanner)).run do |on|
        on.item_to_process{ |item| block.call_event :item_to_process, item}
        on.queue_end{ block.call_event :queue_end }
      end
    end
  end
end
