class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :amount_in_cents
      t.text :description
      t.references :opponent
      t.references :creator
      t.references :winner
      t.string :bet_state_name
      t.datetime :accepted_at
      t.datetime :completed_at

      t.timestamps
    end
    add_index :bets, :opponent_id
    add_index :bets, :creator_id
    add_index :bets, :winner_id
  end
end
