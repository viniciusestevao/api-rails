class CreateUserTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tokens do |t|
      t.string :token
      t.belongs_to :user
      t.string :token_type
      t.datetime :expires_at

      t.timestamps
    end
  end
end
