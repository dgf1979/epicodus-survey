require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Question Integration', { :type => :feature }) do
  describe('Survey Designer - Add Question') do
    it('allows a user to add a question to a survey') do
      survey = Survey.create(title: "Whatever")
      visit("/surveys/#{survey.id}")
      fill_in('question_text', :with => 'Do you like whatever?')
      click_button('Add')
      expect(page).to have_content('Do you like whatever?')
    end
  end

  describe('Delete question') do
    it('allows a user to delete a question for a survey') do
      survey = Survey.create(title: "Whatever survey title")
      survey.questions.create(text: "Whatever question title")
      visit("/surveys/#{survey.id}")
      click_button('Delete')
      expect(page).to have_content('Whatever survey title')
      expect(page).to_not have_content('Whatever question title')
    end
  end

  describe('modify question text') do
    it('allows a user to edit a question for a survey') do
      survey = Survey.create(title: "User Satisfaction")
      question = survey.questions.create(text: "What would you rate your experience?")
      visit("/surveys/#{survey.id}/questions/#{question.id}")
      fill_in('text', :with => 'How would you describe your experience?')
      click_button('Update')
      expect(page).to have_content('How would you describe your experience?')
    end
  end

  describe('validate modifying question text presence') do
    it('redirects to error page if required input is empty') do
      survey = Survey.create(title: "User Satisfaction")
      visit("/surveys/#{survey.id}")
      click_button('Add')
      expect(page).to have_content('Oops there were some errors')
    end
  end

  describe('Input Validation Checks') do
    it('redirects to error page if rename question is empty') do
      survey = Survey.create(title: "User Satisfaction")
      question = survey.questions.create(text: "How satisfied are you with this page?")
      visit("/surveys/#{survey.id}/questions/#{question.id}")
      fill_in('text', :with => '')
      click_button('Update')
      expect(page).to have_content('Oops there were some errors')
    end

    it('redirects to error page if add response field is empty') do
      survey = Survey.create(title: "User Satisfaction")
      question = survey.questions.create(text: "How satisfied are you with this page?")
      visit("/surveys/#{survey.id}/questions/#{question.id}")
      click_button('Add')
      expect(page).to have_content('Oops there were some errors')
    end
  end
end
