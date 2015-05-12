class Question < ActiveRecord::Base
  belongs_to :survey, :foreign_key=>"survey_id"
  has_many(:responses)
  validates_presence_of(:text)
  validates_uniqueness_of(:text, :scope => :survey_id)
end
