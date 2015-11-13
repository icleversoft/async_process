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
      Parallel.each(@folders, in_process: workers_count) do |folder|
        worker = FilesWorker.new(@scanner)
        worker.process_folder( folder ) do |on|
          on.file_in_folder do |file, folder|
            block.call_event :file_to_process, file
            @processed_files += 1
          end
          on.folder_end do |folder|
          end
        end
      end
      block.call_event :queue_end
    end
  end
end
