class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.belongs_to :user, index: true, foreign_key: :user_id
      t.string :name
      t.string :doc_rg
      t.string :doc_cpf
      t.datetime :birth_date
      t.string :phone_1
      t.string :phone_2
      t.string :address_description
      t.string :address_number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :CEP
      t.boolean :is_candidate, null: false, default: false
      t.string :type
      t.timestamps
    end
  end
end
