require_relative './board_game'
require 'active_record'
require 'pry'

class App

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter  => "postgresql",
      # :host     => "localhost",
      # :username => "myuser",
      # :password => "mypass",
      :database => "board_games"
    )
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  # REPL for managing board games
  def run
    puts "Board Game Manager"
    while true do
      menu
      case input
      when '1'
        # Find all
        games = BoardGame.all
        puts games
      when '2'
        # Find by id
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.find(id)
        if game
          puts game.details
        else
          puts "Not found"
        end
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

        if game.save
          puts game
        else
          puts game.errors.messages
        end

      when '4'
        # Edit
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.find(id)
        puts "Which field do you want to edit [name, description, min_players, max_players]?"
        field = input
        puts "New Value?"
        value = input

        begin
          game.update!(field => value)
        rescue ActiveRecord::RecordInvalid => ex
          puts game.errors.messages
        end
      when '5'
        # Delete
        puts "ID of boardgame?"
        id = gets.strip
        game = BoardGame.find(id)
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
