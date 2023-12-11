require 'db_query_matchers'
require 'active_record'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  if ActiveRecord::VERSION::MAJOR > 5
    ActiveRecord::Base.establish_connection adapter:  'sqlite3',
                                            database: ':memory:',
                                            role: :writing
  else
    ActiveRecord::Base.establish_connection adapter:  'sqlite3',
                                            database: ':memory:'
  end

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
