class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, default: 0, null: false
      t.timestamps
    end

    add_index :user, :email, unique: true
  end
end
