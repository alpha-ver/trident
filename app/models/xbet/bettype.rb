class Xbet::Bettype < ApplicationRecord
  belongs_to :betgroup, :class_name => 'Xbet::Betgroup'

  has_many :bets, :class_name => 'Xbet::Bet'
end
