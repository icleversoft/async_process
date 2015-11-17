require 'parallel'
module AsyncProcess
  class Runner
    attr_accessor :process_count
    class << self
      def from_worker( worker, process_count = nil  )
        Runner.new( worker, process_count )
      end
    end

    def initialize( worker, process_count )
      @worker = worker
      @process_count ||= 10
    end

    def run(&block)
      Parallel.each( @worker.items, in_process: process_count ) do |item|
        if @worker.respond_to? :process
          @worker.process( item ) do |on|
            on.process_item do |child_item, item|
              block.call_event :item_to_process, child_item
            end
          end
        else
          block.call_event :item_to_process, item
        end
      end
      block.call_event :queue_end
    end
  end
end
