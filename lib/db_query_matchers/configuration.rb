module DBQueryMatchers
  # Configuration for the DBQueryMatcher module.
  class Configuration
    attr_accessor :ignores, :on_query_counted

    def initialize
      @ignores = []
      @on_query_counted = Proc.new { }
    end
  end
end
