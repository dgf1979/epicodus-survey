class AddResponsesTable < ActiveRecord::Migration
  def change
    create_table(:responses) do |t|
      t.column(:text, :string)
      t.column(:question_id, :int)
      
      t.timestamps
    end
  end
end
