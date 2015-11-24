module AsyncProcess
  class Worker
    attr_reader :items
    def initialize( items = [], options = {} )
      @items = items
    end
  end
end
