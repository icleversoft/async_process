require 'spec_helper'
module AsyncProcess
  describe FilesWorker do
    let(:scanner){FileScanner.new( File.join(File.dirname(__FILE__), '../support', 'root' ) )}
    let(:on_file){lambda{|file| puts "Processing file: #{file}..."}}
    let(:on_end){lambda{puts "Process finished"}}
    let(:worker){FilesWorker.new(scanner, on_file, on_end)}

    it "responds to process_folder" do
      expect(worker).to respond_to :process_folder
    end
    
    context "#process_folder" do
      it "process correctly a folder" do
        expect{worker.process_folder("01")}.to output("Processing file: /Users/gstavrou/Development/rails/async_process/spec/lib/../support/root/01/file4.txt...\nProcess finished\n").to_stdout
      end
    end

  end
end
