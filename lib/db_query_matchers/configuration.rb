module DBQueryMatchers
  # Configuration for the DBQueryMatcher module.
  class Configuration
    attr_accessor :ignores, :on_query_counted, :schemaless

    def initialize
      @ignores = []
      @on_query_counted = Proc.new { }
      @schemaless = false
    end
  end
end
