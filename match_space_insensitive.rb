require 'rspec-custom-matchers'

module SpaceHelpers
  extend CustomMatcher::Helper
  matcher(:white_space_insensitive_match, self) do |string, expected_string|
    Regexp.new(
      '\A' << string.split(/\s+/).map {|part| Regexp.escape(part) }.join('\s*') << '\Z'
    ).match expected_string
  end

  class SpaceProxy
    def ==(other)
      Object.const_get(CustomMatcher.build_class_name('white_space_insensitive_match')).new(other)
    end
  end

  def space
    SpaceProxy.new
  end
end
