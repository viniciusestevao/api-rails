class CreateCandidateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_answers do |t|
      t.belongs_to :test_item
      t.string :description

      t.timestamps
    end
  end
end
