require 'spec_helper'
module AsyncProcess
  describe FilesWorker do
    let(:scanner){FileScanner.new( File.join(File.dirname(__FILE__), '../support', 'root' ) )}
    let(:worker){FilesWorker.new(scanner)}

    it "responds to process_folder" do
      expect(worker).to respond_to :process_folder
    end

    context "#process_folder" do
      it "process correctly a folder" do
        expect{
          worker.process_folder("01") do |on|
            on.file_in_folder do |file, folder|
              print "Processing file: #{file}...\n"
            end
            on.folder_end do |folder|
              print "Process finished"
            end
          end
        }.to output("Processing file: /Users/gstavrou/Development/rails/async_process/spec/lib/../support/root/01/file4.txt...\nProcess finished").to_stdout
      end
    end
  end
end
