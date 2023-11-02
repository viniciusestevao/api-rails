class ChangeStartDateTypeOnApplies < ActiveRecord::Migration[6.0]
  def up
    change_column :applies, :start_date, :string
    change_column :applies, :finish_date, :string
  end

  def down
    change_column :applies, :start_date, :datetime
    change_column :applies, :finish_date, :datetime
  end
end
