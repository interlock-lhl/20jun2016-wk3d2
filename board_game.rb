require 'active_record'

class BoardGame < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }, uniqueness: true
  validates :min_players, presence: true, numericality: { greater_than_or_equal_to: 1, integer_only: true }
  validates :max_players, presence: true, numericality: { greater_than_or_equal_to: 1, integer_only: true }

  has_many :play_sessions
end
