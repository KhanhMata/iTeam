class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :chatwork_id
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
