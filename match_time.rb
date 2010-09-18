require 'rspec-custom-matchers'

module TimeHelpers
  extend CustomMatcher::Helper
  # I think this needs a patch I put in for multiple arguments to the xdotcommer version
  matcher(:be_close_to, self) do |*args|
    time, expected_time, interval = args
    (time - expected_time).abs < (interval || 1)
  end 

  class TimeProxy 
    def ==(other)
      Object.const_get(CustomMatcher.build_class_name('be_close_to')).new(other)
    end 
  end 

  def time
    TimeProxy.new
  end 
end
