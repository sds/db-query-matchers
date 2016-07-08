module DBQueryMatchers
  # Configuration for the DBQueryMatcher module.
  class Configuration
    attr_accessor :ignores, :on_query_counted, :schemaless, :log_backtrace, :backtrace_filter

    def initialize
      @ignores = []
      @on_query_counted = Proc.new { }
      @schemaless = false
      @log_backtrace = false
      @backtrace_filter = Proc.new { |backtrace| backtrace }
    end
  end
end
