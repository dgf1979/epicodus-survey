require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('Survey Integration', { :type => :feature }) do
  describe('Survey Designer - Manage Surveys') do
    it('adds and lists a new survey') do
      visit('/surveys/add')
      fill_in('title', :with => 'User Satisfaction')
      expect(page).to have_content('User Satisfaction')
    end
  end
end
