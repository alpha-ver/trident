class Champ < ApplicationRecord
  belongs_to :sport
  belongs_to :country, optional: true

  has_many :xbet_events, :class_name => 'Xbet::Event'

  scope :xbets, -> { where.not(:api_xbet_id => nil) }
  scope :leons, -> { where.not(:api_leon_id => nil) }

  scope :linked, -> { where.not(:api_leon_id => nil, :api_xbet_id => nil) }

  scope :not_xbets, -> { where(:api_xbet_id => nil) }
  scope :not_leons, -> { where(:api_leon_id => nil) }


  def all_bet_events
    [
      self.xbet_events
    ]
  end



end
