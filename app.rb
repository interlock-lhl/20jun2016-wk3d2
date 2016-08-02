require_relative './board_game'

class App

  # REPL for managing board games
  def run
    puts "Board Game Manager"
    while true do
      menu
      case input
      when '1'
        # Find all
      when '2'
        # Find by id
      when '3'
        # Add
      when '4'
        # Edit
      when '5'
        # Delete
      when '6'
        # Search
      when '0'
        # Exit
        break
      else
        puts "What now?"
      end
    end
    puts "Good Bye!"
  end

  def menu

    puts "1. Browse games"
    puts "2. View game details by id"
    puts "3. Add a game"
    puts "4. Edit a game"
    puts "5. Delete a game"
    puts "6. Search (Bonus!)"
    puts "0. Exit the repl"
  end

  def input
    while true do
      print "> "
      v = gets.strip
      if v.length > 0
        break
      else
        puts "invalid input"
      end
    end
    return v
  end
end

App.new.run
