# db-query-matchers

[![Gem Version](https://badge.fury.io/rb/db-query-matchers.svg)](https://badge.fury.io/rb/db-query-matchers)
[![Build Status](https://github.com/civiccc/db-query-matchers/actions/workflows/ci.yml/badge.svg)](https://github.com/civiccc/db-query-matchers/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/776d6f7223e01be5f17a/maintainability)](https://codeclimate.com/github/brigade/db-query-matchers/maintainability)

RSpec matchers for database queries made by ActiveRecord.

## Installation

Add this line to your application's Gemfile, preferably in your `test` group:

```ruby
gem 'db-query-matchers'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install db-query-matchers
```

## Usage

```ruby
describe 'MyCode' do
  context 'when we expect no queries' do
    it 'does not make database queries' do
      expect { subject.make_no_queries }.to_not make_database_queries
    end
  end

  context 'when we expect queries' do
    it 'makes database queries' do
      expect { subject.make_some_queries }.to make_database_queries
    end
  end

  context 'when we expect exactly 1 query' do
    it 'makes database queries' do
      expect { subject.make_one_query }.to make_database_queries(count: 1)
    end
  end

  context 'when we expect max 3 queries' do
    it 'makes database queries' do
      expect { subject.make_several_queries }.to make_database_queries(count: 0..3)
    end
  end

  context 'when we expect a possible range of queries' do
    it 'makes database queries' do
      expect { subject.make_several_queries }.to make_database_queries(count: 3..5)
    end
  end

  context 'when we only care about manipulative queries (INSERT, UPDATE, DELETE)' do
    it 'makes a destructive database query' do
      expect { subject.make_one_query }.to make_database_queries(manipulative: true)
    end
  end

  context 'when we only care about unscoped queries (SELECT without a WHERE or LIMIT clause))' do
    it 'makes an unscoped database query' do
      expect { subject.make_one_query }.to make_database_queries(unscoped: true)
    end
  end

  context 'when we only care about queries matching a certain pattern' do
    it 'makes a destructive database query' do
      expect { subject.make_special_queries }.to make_database_queries(matching: 'DELETE * FROM')
    end

    it 'makes a destructive database query matched with a regexp' do
      expect { subject.make_special_queries }.to make_database_queries(matching: /DELETE/)
    end
  end
end
```

## Configuration

To exclude certain types of queries from being counted, specify an
`ignores` configuration consisting of an array of regular expressions. If
a query matches one of the patterns in this array, it will not be
counted in the `make_database_queries` matcher.

To exclude queries previously cached by ActiveRecord from being counted,
add `ignore_cached` to the configuration.

To exclude SCHEMA queries, add `schemaless` to the configuration. This will
help avoid failing specs due to ActiveRecord load order.

To log more about the queries being made, you can set the `log_backtrace`
option to `true`. And to control what parts of the backtrace is logged,
you can use `backtrace_filter`.

```ruby
DBQueryMatchers.configure do |config|
  config.ignores = [/SHOW TABLES LIKE/]
  config.ignore_cached = true
  config.schemaless = true

  # the payload argument is described here:
  # http://edgeguides.rubyonrails.org/active_support_instrumentation.html#sql-active-record
  config.on_query_counted do |payload|
    # do something arbitrary with the query
  end

  config.log_backtrace = true
  config.backtrace_filter = Proc.new do |backtrace|
    backtrace.select { |line| line.start_with?(Rails.root.to_s) }
  end
end
```
