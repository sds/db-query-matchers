# coding: utf-8
$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'db_query_matchers/version'

Gem::Specification.new do |spec|
  spec.name          = 'db-query-matchers'
  spec.version       = DBQueryMatchers::VERSION
  spec.authors       = ['Causes Engineering', 'Henric Trotzig', 'Joe Lencioni']
  spec.email         = ['eng@causes.com', 'henric.trotzig@causes.com',
                        'joe.lencioni@causes.com']
  spec.summary       = 'RSpec matchers for database queries'
  spec.homepage      = 'https://github.com/causes/db-query-matchers'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'activesupport', '~> 4.0'
  spec.add_development_dependency 'activerecord',  '~> 4.0'
  spec.add_development_dependency 'sqlite3'
end
