class Sport < ApplicationRecord
  has_many :commands
  has_many :champs

  scope :xbets, -> { where.not(:api_xbet_id => nil) }
  scope :leons, -> { where.not(:api_leon_id => nil) }

  scope :linked, -> { where.not(:api_leon_id => nil, :api_xbet_id => nil) }

  scope :not_xbets, -> { where(:api_xbet_id => nil) }
  scope :not_leons, -> { where(:api_leon_id => nil) }


end
