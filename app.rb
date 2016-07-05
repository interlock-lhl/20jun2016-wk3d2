require 'active_record'
require_relative './board_game'
require_relative './play_session'

class App

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter  => "postgresql",
      :host     => "localhost",
      :username => "jamessapara",
      :database => "board_games"
    )
  end

  def run
    # puts bg.inspect
    # puts BoardGame.findAll().inspect
    # puts BoardGame.find(2).inspect
    # bg = BoardGame.new({'name' => "Pandemic", 'min_players' => 2, 'max_players' => 6, 'description' => "Humanity dies!"})
    # bg.save
    bg = BoardGame.find(2)
    # bg.max_players = 4
    # bg.save

    puts bg.inspect
  end
end

App.new.run
