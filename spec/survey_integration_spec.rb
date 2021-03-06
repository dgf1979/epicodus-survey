require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('Survey Integration', { :type => :feature }) do
  describe('Survey Designer - Manage Surveys') do
    it('adds and lists a new survey') do
      visit('/surveys')
      fill_in('title', :with => 'User Satisfaction')
      click_button('Add')
      expect(page).to have_content('User Satisfaction')
    end
  end

  describe('Survey Designer - Edit Survey') do
    it('allows user to edit the title of the survey') do
      survey = Survey.create(title: "User Satisfaction")
      visit("/surveys/#{survey.id}")
      fill_in('title', :with => 'Job Satisfaction')
      click_button('Update')
      expect(page).to have_content('Job Satisfaction')
    end
  end

  describe('Survey Designer - Delete Survey') do
    it('allows a user to delete a survey') do
      survey = Survey.create(title: "Only survey")
      visit("/surveys")
      click_button('Delete')
      expect(page).to_not have_content("Only survey")
    end
  end

  describe('Input Validation Checks') do
    it('redirects to error page if required add new question input is empty') do
      visit('/surveys')
      click_button('Add')
      expect(page).to have_content('Oops there were some errors')
    end

    it('redirects to error page if rename survey is empty') do
      survey = Survey.create(title: "Only survey")
      visit("/surveys/#{survey.id}")
      click_button('Update')
      expect(page).to have_content('Oops there were some errors')
    end
  end
end
