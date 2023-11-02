class CreateRightAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :right_answers do |t|
      
      t.string :description

      t.timestamps
    end
  end
end
