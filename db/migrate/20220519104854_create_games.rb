class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :board1, default: ""
      t.string :board2,default: ""
      t.boolean :turn, default: true
      t.integer :state, default: 0
      t.belongs_to :player1
      t.belongs_to :player2

      t.timestamps
    end
  end
end
