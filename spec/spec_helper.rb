ENV['RACK_ENV'] = 'test'

require('sinatra/activerecord')
require('rspec')
require('pg')
require('pry')
require('./lib/survey')

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
