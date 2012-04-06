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

    redirect_to :controller => "users", :action => "show"
  end
end
