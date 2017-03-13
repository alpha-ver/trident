class Xbet::Betgroup < ApplicationRecord
  has_many :bettypes, :class_name => 'Xbet::Bettype'
end
