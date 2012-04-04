class CreateBetStates < ActiveRecord::Migration
  def change
    create_table :bet_states do |t|
      t.string :state_name

      t.timestamps
    end

    ["Proposing", "Accepted", "Declined", "Settling", "Completed", "Incomplete", "Expired"].each do |name|
      BetState.create!(:state_name => name)
    end
  end
end
