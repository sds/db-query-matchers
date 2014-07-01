module DBQueryMatchers
  # Configuration for the DBQueryMatcher module.
  class Configuration
    attr_accessor :ignores

    def initialize
      @ignores = []
    end
  end
end
