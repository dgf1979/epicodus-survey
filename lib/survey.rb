class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:title_case)

  private

  define_method(:title_case) do
    self.title = title.capitalize
  end
end
