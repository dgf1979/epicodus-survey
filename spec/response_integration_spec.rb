require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Question Integration', { :type => :feature }) do
  it('allows a user to add a response option to a question') do
    survey = Survey.create(title: "Satisfaction Survey")
    question = survey.questions.create(text: 'How did you like it?')
    visit("/surveys/#{survey.id}/questions/#{question.id}")
    fill_in('response_text', :with => 'Not Very Much')
    click_button('Add')
    fill_in('response_text', :with => 'A Lot')
    click_button('Add')
    expect(page).to have_content('Not Very Much')
    expect(page).to have_content('A Lot')
  end

  it('allows a user to delete a response option to a question') do
    survey = Survey.create(title: "Satisfaction Survey")
    question = survey.questions.create(text: 'How did you like it?')
    response = question.responses.create(text: 'I agree')
    visit("/surveys/#{survey.id}/questions/#{question.id}")
    click_button('Delete')
    expect(page).to_not have_content('I agree')
  end


end
