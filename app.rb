require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/question')
require('./lib/response')
require('./lib/survey')
require('pry')
require('pg')


get('/test') do
  @test_var = 'Sinatra OK'
  erb(:test)
  #redirect to('/')
end

get('/') do
  erb(:index)
end

#SURVEY
get('/surveys') do
  erb(:surveys)
end

get('/surveys/add') do
  erb(:survey_add_form)
end

post('/surveys/add') do
  
  redirect to('/surveys')
end
