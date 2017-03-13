class Champ < ApplicationRecord
  belongs_to :sport
  belongs_to :country, optional: true

  has_many :xbet_events, :class_name => 'Xbet::Event'

  scope :xbets, -> { where.not(:api_xbet_id => nil) }
end
