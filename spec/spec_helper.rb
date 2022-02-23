require 'db_query_matchers'
require 'active_record'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  if Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('6.0.0')
    ActiveRecord::Base.connects_to database: { writing: :primary, reading: :replica }
  end

  ActiveRecord::Base.establish_connection adapter:  'sqlite3',
                                          database: ':memory:'

  ActiveRecord::Schema.define do
    self.verbose = false

    create_table :cats, :force => true do |t|
      t.column :name, :string
    end

    create_table :dogs, :force => true do |t|
      t.column :name, :string
    end
  end
end
