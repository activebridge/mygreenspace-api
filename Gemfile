source 'https://rubygems.org'

gem 'rails',                    '4.1.7'
gem 'rails-api',                '~> 0.3.0'  # lightweight rails app built for apis
gem 'pg',                       '~> 0.17.1' # for access to the postgres database
gem 'rails_config',             '~> 0.4.2'  # for multi-environment yaml settings
gem 'rack-timeout',             '~> 0.1.0'  # for aborting requests that are taking too long
gem 'jbuilder',                 '~> 2.2.3'  # for creating json structure
gem 'oj',                       '~> 2.10.3' # for parsing incoming json requests
gem 'unicorn',                  '~> 4.8.3'  # for serving http requests
gem 'doorkeeper',               '~> 1.4.0'  # OAuth 2 provider for rails
gem 'doorkeeper-grants_assertion'           # integrates sign in with facebook



group :development do
  gem 'spring',                 '~> 1.1.3'  # for fast rails actions via pre-loading
  gem 'spring-commands-rspec',  '~> 1.0.2'  # for rspec support in spring
  gem 'better_errors',          '~> 2.0.0'  # for better debugging
  gem 'rails-erd', git: 'https://github.com/paulwittmann/rails-erd', branch: 'mavericks'
                                            # for generating entity-relationship diagrams
end

group :development, :test do
  gem 'rspec-rails',            '~> 3.1.0'  # for unit testing
  gem 'factory_girl_rails',     '~> 4.5.0'  # for test data
  gem 'pry-rails',              '~> 0.3.2'  # for interactively exploring objects
  gem 'awesome_print',          '~> 1.2.0'  # required dependency for pry-rails
  gem 'pry',                    '~> 0.10.1' # required dependency for pry-rails
  gem 'binding_of_caller',      '~> 0.7.2'  # optional helper for better_errors
  gem 'database_cleaner',       '~> 1.3.0'  # for cleaning databases
  gem 'did_you_mean',           '~> 0.9.4'  # for catching human blunders
  gem 'dotenv-rails',           '~> 1.0.2'  # for loading environment variables
  gem 'faker',                  '~> 1.4.3'  # used for factories to generate test data
  gem 'rspec-collection_matchers'
end

group :test do
  gem 'shoulda-matchers',       '~> 2.7.0', require: false  # for common rspec matchers
end

group :staging do
  gem 'rails_12factor',         '~> 0.0.3'  # for serving assets and logging support in heroku
end
