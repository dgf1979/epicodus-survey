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
  @object = Survey.new(title: params["title"])
  if @object.save
    redirect back
  else
    erb(:errors)
  end

  #Survey.create(title: params["title"])
  #redirect to('/surveys')
end

get('/surveys/:id') do |id|
  @survey = Survey.find(id.to_i)
  @questions = @survey.questions
  erb(:survey)
end

patch('/surveys/:id') do |id|
  @object = Survey.find(id.to_i)
  if @object.update(title: params['title'])
    redirect back
  else
    erb(:errors)
  end
  #redirect to("/surveys/#{id}")
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
  survey = Survey.find(survey_id.to_i)
  @object = survey.questions.new(text: params["question_text"])

  if @object.save
    redirect to("surveys/#{survey_id}")
  else
    erb(:errors)
  end
end

get('/surveys/:survey_id/questions/:id') do |survey_id, id|
  @survey    = Survey.find(survey_id.to_i)
  @question  = @survey.questions.find(id.to_i)
  @responses = @question.responses
  erb(:question)
end

patch('/surveys/:survey_id/questions/:id') do |survey_id, id|
  @object = Survey.find(survey_id.to_i).questions.find(id.to_i)
  if @object.update(text: params['text'])
    redirect to("/surveys/#{survey_id}/questions/#{id}")
  else
    erb(:errors)
  end
end

delete('/surveys/:survey_id/questions/:id') do |survey_id, id|
  Survey.find(survey_id.to_i).questions.find(id.to_i).destroy()
  redirect to("/surveys/#{survey_id}")
end


#RESPONSES
delete('/surveys/:survey_id/questions/:question_id/responses/:id') do |survey_id, question_id, id|
  Response.find(id).destroy
  redirect back
end

post('/surveys/:survey_id/questions/:question_id/responses') do |survey_id, question_id|
  @question = Question.find(question_id.to_i)
  @object = @question.responses.new(text: params["response_text"])
  if @object.save
    redirect back
  else
    erb(:errors)
  end
end
