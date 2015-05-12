ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('pry')
require('sinatra/activerecord')
require('survey')

db_options = {adapter: 'postgresql', database: 'survey_test'}
ActiveRecord::Base.establish_connection(db_options)

ActiveRecord::Base.logger = Logger.new(STDOUT)

RSpec.configure do |config|
  config.before(:each) do
    #optionally do something before each test
  end
  config.after(:each) do
    #optionally do something after each test
    Survey.all().each do |survey|
      survey.destroy()
    end
  end
end
