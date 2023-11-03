class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :tag
      t.string :description
      t.string :question_type, null: false
      t.jsonb :body, null: false, default: []

      # t.string :option_a
      # t.string :option_b
      # t.string :option_c
      # t.string :option_d
      # t.string :option_e
      # t.string :right_answer
      t.boolean :can_copy

      t.timestamps
    end
  end
end
