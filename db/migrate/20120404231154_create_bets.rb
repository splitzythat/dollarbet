class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :amount_in_cents
      t.text :description
      t.references :opponent
      t.references :creator
      t.references :winner
      t.references :bet_state

      t.timestamps
    end
    add_index :bets, :opponent_id
    add_index :bets, :creator_id
    add_index :bets, :winner_id
    add_index :bets, :bet_state_id
  end
end
