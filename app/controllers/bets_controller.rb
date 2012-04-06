class BetsController < ApplicationController
  def new
    @bet = Bet.new
    @user = current_user
  end

  def create
    opponent = User.find_by_name(params[:bet][:opponent])
    creator = User.find(params[:bet][:creator].to_i)
    params[:bet].merge!({:opponent => opponent, :creator => creator, :amount_in_cents => 100})
    @bet = Bet.create!(params[:bet])

    redirect_to root_path
  end

  def update
    if params[:bet][:state_action].present?
      update_state
    else
      redirect_to root_path
    end
  end

  def update_state
    bet = Bet.find(params[:id])
    case params[:bet][:state_action]
    when "accept"
      bet.both_players_take_bet!
    when "reject"
      bet.second_player_does_not_take_bet!
    when "delete"
      bet = Bet.find(params[:id])
      bet.delete
    when "set_winner"
      bet = Bet.find(params[:id])
      winner = User.find(params[:bet][:winner_id])
      if bet.winner.present?
        if bet.winner == winner
          bet.both_players_agree_to_end_bet!
        else
          bet.second_player_does_not_end_bet!
        end
      else
        bet.winner = winner
        bet.save!
        bet.one_player_wants_to_end_bet!
      end
    end

    redirect_to root_path
  end
end
