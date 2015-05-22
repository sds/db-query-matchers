# db-query-matchers

[![Gem Version](https://badge.fury.io/rb/db-query-matchers.png)](http://badge.fury.io/rb/db-query-matchers)
[![Build Status](https://travis-ci.org/brigade/db-query-matchers.png)](https://travis-ci.org/brigade/db-query-matchers)
[![Code Climate](https://codeclimate.com/github/brigade/db-query-matchers.png)](https://codeclimate.com/github/brigade/db-query-matchers)
[![Dependency Status](https://gemnasium.com/brigade/db-query-matchers.png)](https://gemnasium.com/brigade/db-query-matchers)

RSpec matchers for database queries.

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

  context 'when we only care about manipulative queries (INSERT, UPDATE, DELETE)' do
    it 'makes a destructive database query' do
      expect { subject.make_one_query }.to make_database_queries(manipulative: true)
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

```ruby
DBQueryMatchers.configure do |config|
  config.ignores = [/SHOW TABLES LIKE/]
end
```

## Contributing

1. Fork it ( https://github.com/brigade/db-query-matchers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
