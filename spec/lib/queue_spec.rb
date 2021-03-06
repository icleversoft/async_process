require 'spec_helper'
module AsyncProcess
  describe Queue do
    let(:queue){Queue.new(FileScanner.new(File.join(File.dirname(__FILE__), '../support', 'root')))}

    it "scanner is actually a FileScanner" do
      expect(queue.scanner).to be_an FileScanner
    end

    it "responds to process" do
      expect(queue).to respond_to :process
    end

    it "holds correctly folder's size" do
      expect(queue.size).to eq 10
    end

    context "#workers_count" do
      it "holds a default value" do
        expect(queue.workers_count).to eq Queue::CONCURRENT_WORKERS
      end

      it "raises an error when a value smaller than 1 is being set" do
        expect{queue.workers_count = 0}.to raise_error ArgumentError
      end

      it "changes workers_count for a new value" do
        queue.workers_count = 4
        expect(queue.workers_count).to eq 4
      end
    end
    
    context "#process" do
      it "raises an error when no block is provided" do
        expect{queue.process}.to raise_error LoadError
      end
      it "process each folder successfully" do
        queue.process do |on|
          on.item_to_process do |file|
            p file 
          end
          on.queue_end do
            p "queue end"
          end
        end
      end
    end

  end

end
