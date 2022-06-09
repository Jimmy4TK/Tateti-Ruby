class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.belongs_to :game, index: false
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
