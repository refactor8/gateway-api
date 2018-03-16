class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :subdomain, null: false
      t.belongs_to :user, type: :uuid, index: true
      t.timestamps
    end
  end
end
