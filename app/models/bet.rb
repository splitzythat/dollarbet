class Bet < ActiveRecord::Base
  belongs_to :opponent, :class_name => "User"
  belongs_to :creator, :class_name => "User"
  belongs_to :winner, :class_name => "User"
  belongs_to :bet_state
end
