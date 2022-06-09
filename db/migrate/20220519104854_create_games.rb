class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :pos, default: "0,0,0,0,0,0,0,0,0"
      t.boolean :team, default: true
      t.integer :state, default: 0      

      t.timestamps
    end
  end
end
