require 'spec_helper'
describe "Event" do
  it "forwards any defined event" do
    def foo(msg, &block) 
      block.call_event :success 
      block.call_event :failure, "error"
    end
    expect{foo("my message") do |on|
      on.success do
        print "success"
      end
      on.failure do |msg|
        print "\nfail:#{msg}"
      end
    end}.to output("success\nfail:error").to_stdout
  end
end
