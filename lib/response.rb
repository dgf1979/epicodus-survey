class Response < ActiveRecord::Base
  belongs_to(:question)
  validates_presence_of(:text)
  validates_uniqueness_of(:text, :scope => :question_id)
end
