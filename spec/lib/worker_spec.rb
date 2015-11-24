require 'spec_helper'

module AsyncProcess
  describe Worker do
    let(:worker){ Worker.new([3, 4]) }
    it "returns the array that is passed with its initialization" do
       expect(worker.items).to be_an Array
    end

    it "returns exactly the elements of array was set with its initialization" do
      expect(worker.items).to match_array [3, 4]
    end
  end
end
