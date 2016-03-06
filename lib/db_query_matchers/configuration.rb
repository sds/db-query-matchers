module DBQueryMatchers
  # Configuration for the DBQueryMatcher module.
  class Configuration
    attr_accessor :ignores, :on_counted_query

    def initialize
      @ignores = []
      @on_counted_query = Proc.new { }
    end
  end
end
