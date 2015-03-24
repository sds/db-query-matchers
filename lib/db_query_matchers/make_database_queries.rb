require 'rspec/core'
require 'rspec/expectations'
require 'rspec/mocks'

# Custom matcher to check for database queries performed by a block of code.
#
# @example
#   expect { subject }.to_not make_database_queries
#
# @example
#   expect { subject }.to make_database_queries(count: 1)
#
# @example
#   expect { subject }.to make_database_queries(no_more_than: 2)
#
# @example
#   expect { subject }.to make_database_queries(manipulative: true)
#
# @see DBQueryMatchers::QueryCounter
RSpec::Matchers.define :make_database_queries do |options = {}|
  if RSpec::Core::Version::STRING =~ /^2/
    def self.failure_message_when_negated(&block)
      failure_message_for_should_not(&block)
    end

    def self.failure_message(&block)
      failure_message_for_should(&block)
    end

    def supports_block_expectations?
      true
    end
  else
    supports_block_expectations
  end

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
    counter_options = {}
    if options[:manipulative]
      counter_options[:matches] = [/^\ *(INSERT|UPDATE|DELETE\ FROM)/]
    end
    @counter = DBQueryMatchers::QueryCounter.new(counter_options)
    ActiveSupport::Notifications.subscribed(@counter.to_proc,
                                            'sql.active_record',
                                            &block)

    # In case both :count and :no_more_than options are present, we give
    # priority to the :count option.
    if absolute_count = options[:count]
      @counter.count == absolute_count
    elsif absolute_count = options[:no_more_than]
      @counter.count <= absolute_count
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
    elsif options[:no_more_than]
      expected = pluralize(options[:no_more_than], 'query')
      actual   = pluralize(@counter.count, 'was', 'were')

      output   = "expected no more than #{expected}, but #{actual} made"
      if @counter.count > 0
        output += ":\n#{@counter.log.join("\n")}"
      end
      output
    else
      'expected queries, but none were made'
    end
  end
end
