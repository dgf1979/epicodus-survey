require('spec_helper')

describe(Survey) do
  describe('#title_case') do
    it('up-cases the first letter in a title') do
      test_survey = Survey.create(title: 'new survey')
      expect(test_survey.title()).to(eq('New survey'))
    end
  end
end
