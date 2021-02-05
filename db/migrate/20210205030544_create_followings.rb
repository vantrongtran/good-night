class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.bigint :following_user_id, null: false

      t.timestamps
    end
    add_foreign_key :followings, :users, column: :following_user_id, index: true
    add_index :followings, [:user_id, :following_user_id], unique: true
  end
end
