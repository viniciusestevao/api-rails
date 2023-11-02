class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.boolean :active, null: false, default: false
      t.boolean :is_admin, default: false
      
      t.timestamps
    end
  end
end
