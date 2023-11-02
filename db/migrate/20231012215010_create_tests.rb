class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :title
      t.belongs_to :apply, foreign_key: true
      t.string :description
      t.string :instruction
      t.boolean :can_copy

      t.timestamps
    end
  end
end
