require_relative './board_game'

class App

  def run
    # puts bg.inspect
    # puts BoardGame.findAll().inspect
    # puts BoardGame.find(2).inspect
    # bg = BoardGame.new({'name' => "Pandemic", 'min_players' => 2, 'max_players' => 6, 'description' => "Humanity dies!"})
    # bg.save
    bg = BoardGame.find(9)
    # bg.max_players = 4
    # bg.save
    bg.delete
    puts bg.inspect
  end
end

App.new.run
