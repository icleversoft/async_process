require 'spec_helper'
module AsyncProcess
  describe FilesWorker do
    let(:scanner){FileScanner.new( File.join(File.dirname(__FILE__), '../support', 'root' ) )}
    let(:worker){FilesWorker.new(scanner)}

    it "responds to process" do
      expect(worker).to respond_to :process
    end

    context "#process_folder" do
      it "process correctly a folder" do
        expect{
          worker.process("01") do |on|
            on.process_item do |file, folder|
              print "Processing file: #{file}...\n"
            end
            on.collection_end do |folder|
              print "Process finished"
            end
          end
        }.to output("Processing file: /Users/gstavrou/Development/rails/async_process/spec/lib/../support/root/01/file4.txt...\nProcess finished").to_stdout
      end
    end
  end
end
