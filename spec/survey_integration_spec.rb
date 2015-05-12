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
      click_button('Submit')
      expect(page).to have_content('Job Satisfaction')
    end
  end
end
