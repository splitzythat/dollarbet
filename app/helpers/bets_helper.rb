module BetsHelper
  def bet_button(bet, action, state_action = nil, extra_params = {})
    state_action = action.downcase if !state_action
    button_to(action, bet_path(:id => bet.id, :bet => {:state_action => state_action}.merge(extra_params)), :method => :put)
  end
end
