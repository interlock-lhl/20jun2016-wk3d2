require 'active_record'

class BoardGame < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :min_players, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max_players, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  class << self
    # TODO as scope
    def search(term)
      self.where("name ILIKE ? OR description ILIKE ?", "%#{term}%","%#{term}%").all
    end
  end

  def to_s
    "ID: #{id} Name: #{name}"
  end

  def details
    "ID: #{id}\nName: #{name}\nPlayers Min(#{min_players}) Max(#{max_players})\nDescription:\n#{description}\n\nCreated At: #{created_at} Updated: #{updated_at}"
  end
end
