require 'spec_helper'

module AsyncProcess
  describe Runner do
    context "simple worker" do
      let(:worker){Worker.new((1..100))}
      it "process a simple worker" do
        runner = Runner.from_worker( worker, 1 )
        runner.run do |on|
          on.item_to_process do |item|
            print "#{item}\n" 
          end
          on.queue_end do
            p "End"
          end
        end
      end
    end
  end

end
