require_relative './board_game'
require 'pry'
class App

  # REPL for managing board games
  def run
    puts "Board Game Manager"
    while true do
      menu
      case input
      when '1'
        # Find all
        games = BoardGame.findAll
        puts games
      when '2'
        # Find by id
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.findById(id)
        puts game.details
      when '3'
        # Add
        game = BoardGame.new
        puts "Name of the Game?"
        game.name = input
        puts "Min Players?"
        game.min_players = input
        puts "Max Players?"
        game.max_players = input
        puts "Description?"
        game.description = input

        game.insert
        puts game
      when '4'
        # Edit
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.findById(id)
        puts "Which field do you want to edit [name, description, min_players, max_players]?"
        field = input
        puts "New Value?"
        value = input
        game.send("#{field}=", value)

        game.update
        puts game.details
      when '5'
        # Delete
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.findById(id)
        game.destroy # DELETE from DB
      when '6'
        # Search
        puts "Search term?"
        term = input
        games = BoardGame.search(term)
        puts games
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
    v
  end
end

App.new.run
