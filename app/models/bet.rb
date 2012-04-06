class Bet < ActiveRecord::Base
  belongs_to :opponent, :class_name => "User"
  belongs_to :creator, :class_name => "User"
  belongs_to :winner, :class_name => "User"

  EXPIRATION_DAYS = 7

  include AASM

  aasm :column => :bet_state_name do
    state :proposing
    state :accepted, :enter => :set_accepted_date
    state :rejected
    state :settling
    state :completed, :enter => :set_completed_date
    state :incomplete, :enter => :unset_winner
    state :expired

    event :both_players_take_bet do
      transitions :to => :accepted, :from => :proposing
    end

    event :second_player_does_not_take_bet do
      transitions :to => :rejected, :from => :proposing
    end

    event :one_player_wants_to_end_bet do
      transitions :to => :settling, :from => :accepted
    end

    event :both_players_agree_to_end_bet do
      transitions :to => :completed, :from => :settling
    end

    event :second_player_does_not_end_bet do
      transitions :to => :incomplete, :from => :settling
    end

    event :set_expired do
      transitions :to => :expired, :from => [:proposing, :accepted, :rejected, :settling, :incomplete]
    end
  end
  aasm_initial_state :proposing

  def set_accepted_date
    accepted_at = Time.now
  end

  def set_completed_date
    completed_at = Time.now
  end

  def set_completed_date
    winner = nil
  end

  def set_old_to_expired
    date_to_check = proposing? ? accepted_at : created_at
    set_expired! if (date_to_check + EXPIRATION_DAYS.days) < Time.now
  end
end
