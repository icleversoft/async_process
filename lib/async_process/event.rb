class Proc
  def call_event( method, *args )
    anonymous = Class.new do
      define_method method.to_sym do |&b|
        b.nil? ? true : b.call( *args )
      end
      def method_missing( method, *args, &block ) false; end
    end
    self.call( anonymous.new )
  end
end
