class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:title_case)
  validates_presence_of(:title)

  private

  define_method(:title_case) do
    self.title = title[0].upcase + title[1..-1]
  end
end
