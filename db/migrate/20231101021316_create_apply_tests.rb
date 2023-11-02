class CreateApplyTests < ActiveRecord::Migration[6.0]
  def change
    create_table :apply_tests do |t|
      t.belongs_to :apply
      t.belongs_to :test

      t.string :title
      t.string :description
      t.string :instruction
    end
  end
end
