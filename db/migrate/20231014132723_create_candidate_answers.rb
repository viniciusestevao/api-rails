class CreateCandidateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_answers do |t|
      t.belongs_to :apply, foreign_key: true
      t.belongs_to :test, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
