class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :token, null: false, index: true, unique: true
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
