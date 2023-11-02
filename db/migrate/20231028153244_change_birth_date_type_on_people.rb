class ChangeBirthDateTypeOnPeople < ActiveRecord::Migration[6.0]
  def up
    change_column :people, :birth_date, :string
  end

  def down
    change_column :people, :birth_date, :datetime
  end
end
