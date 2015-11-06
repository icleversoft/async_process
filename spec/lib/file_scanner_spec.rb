require 'spec_helper'
module AsyncProcess
  describe FileScanner do
    let(:scanner){FileScanner.new( File.join(File.dirname(__FILE__), '../support', 'root' ) )}
    it "responds to folders" do
      expect(subject).to respond_to :folders
    end

    it "responds to files_for_folder" do
      expect(subject).to respond_to :files_for_folder
    end

    context "#folders" do
      it "reads correctly all retained folders" do
        expect(scanner.folders.length).to eq 10
      end

      it "should contain the right data" do
        expect(scanner.folders).to match_array %w(01 02 03 04 05 06 07 08 09 10)
      end
    end

    context "#files_for_folder" do
      it "reads correctly all contained files" do
        expect(scanner.files_for_folder("10").length).to eq 9
      end

      it "reads correctly the name of each contained file" do
        files = [5, 10, 25, 28, 36, 46, 65, 72, 92].collect{|x| "file#{x}.txt"}
        expect(scanner.files_for_folder("10")).to match_array files 
      end
    end

  end
end
