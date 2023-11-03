class CreateTestItems < ActiveRecord::Migration[6.0]
  def change
    create_table :test_items do |t|
      t.belongs_to :apply_test
      t.belongs_to :question
      t.string :description
      t.string :question_type, null: false
      t.jsonb :body, null: false, default: []
      t.string :answer

      t.timestamps
    end
  end
end
