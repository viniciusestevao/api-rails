class CreateApplies < ActiveRecord::Migration[6.0]
  def change
    create_table :applies do |t|
      t.belongs_to :candidate, index: true, foreign_key: { to_table: :people }, column: :person_id
      t.belongs_to :recruiter, index: true, foreign_key: { to_table: :people }, column: :person_id
      t.datetime :create_date
      t.datetime :start_date
      t.datetime :finish_date
      t.string :comment
    end
  end
end
