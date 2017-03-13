class Sport < ApplicationRecord
  has_many :commands
  has_many :champs

  scope :xbets, -> { where.not(:api_xbet_id => nil) }
end
