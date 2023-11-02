class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :tag
      t.belongs_to :test, foreign_key: true
      t.string :description
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :option_e
      t.boolean :can_copy

      t.timestamps
    end
  end
end
