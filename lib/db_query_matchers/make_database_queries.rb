require 'rspec'

# Custom matcher to check for database queries performed by a block of code.
#
# @example
#   expect { subject }.to_not make_database_queries
#
# @example
#   expect { subject }.to make_database_queries(count: 1)
#
# @see QueryCounter
RSpec::Matchers.define :make_database_queries do |options = {}|
  supports_block_expectations

  # Taken from ActionView::Helpers::TextHelper
  def pluralize(count, singular, plural = nil)
    word = if count == 1 || count =~ /^1(\.0+)?$/
             singular
           else
             plural || singular.pluralize
           end

    "#{count || 0} #{word}"
  end

  match do |block|
    @counter = QueryCounter.new
    ActiveSupport::Notifications.subscribed(@counter.to_proc,
                                            'sql.active_record',
                                            &block)
    if absolute_count = options[:count]
      @counter.count == absolute_count
    else
      @counter.count > 0
    end
  end

  failure_message_when_negated do |_|
    <<-EOS
      expected no queries, but #{@counter.count} were made:
      #{@counter.log.join("\n")}
    EOS
  end

  failure_message do |_|
    if options[:count]
      expected = pluralize(options[:count], 'query')
      actual   = pluralize(@counter.count, 'was', 'were')

      output   = "expected #{expected}, but #{actual} made"
      if @counter.count > 0
        output += ":\n#{@counter.log.join("\n")}"
      end
      output
    else
      'expected queries, but none were made'
    end
  end
end
