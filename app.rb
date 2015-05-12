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
  @surveys = Survey.all
  erb(:surveys)
end

post('/surveys') do
  Survey.create(title: params["title"])
  redirect to('/surveys')
end

get('/surveys/:id') do |id|
  @survey = Survey.find(id.to_i)
  erb(:survey)
end

patch('/surveys/:id') do |id|
  @survey = Survey.find(id.to_i)
  @survey.update(title: params['title'])
  redirect to("/surveys/#{id}")
end

delete('/surveys/:id') do |id|
  Survey.find(id.to_i).destroy()
  redirect to("/surveys")
end

#QUESTIONS
get('/surveys/:survey_id/questions') do
  erb(:questions)
end

post('/surveys/:survey_id/questions') do |survey_id|
  survey_id = survey_id.to_i
  redirect to("surveys/#{survey_id}")
end

get('/surveys/:survey_id/questions/:id') do |survey_id, id|

end

patch('/surveys/:survey_id/questions/:id') do |survey_id, id|

end

delete('/surveys/:survey_id/questions/:id') do |survey_id, id|

end


#RESPONSES
