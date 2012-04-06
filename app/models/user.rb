class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :created_bets, :class_name => "Bet", :foreign_key => "creator_id"
  has_many :involved_bets, :class_name => "Bet", :foreign_key => "opponent_id"

  def bets
    created_bets + involved_bets
  end
end
