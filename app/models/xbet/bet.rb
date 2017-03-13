class Xbet::Bet < ApplicationRecord
  belongs_to :event,    :class_name => 'Xbet::Event'
  belongs_to :bettype,  :class_name => 'XBet::Bettype'
end
