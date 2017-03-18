class Xbet::Bet < ApplicationRecord
  belongs_to :event,    :class_name => 'Xbet::Event'
  belongs_to :bettype#,  :class_name => 'XBet::Bettype'

  def self.add(res, id)
    events = res.map do |event|
      #ap event
      [
        id,
        event[:T],
        event[:C],
        event[:B] == 0 ? true : false,
        event[:P],
        event[:PL],
        event
      ]
    end

    self.import [:event_id, :bettype_id, :ratio, :active, :p, :pl, :dl], events

  end
end
