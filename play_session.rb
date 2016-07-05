require 'active_record'

class PlaySession < ActiveRecord::Base
  belongs_to :board_game
end
