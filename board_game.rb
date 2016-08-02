require_relative './base'

class BoardGame < Base

  attr_reader :id
  attr_accessor :name, :min_players, :max_players, :description, :created_at, :updated_at

  def initialize(params={})
    update_attributes(params)
  end

  def insert
    res = Base.connection.exec_params(
      'INSERT INTO board_games (name, min_players, max_players, description, created_at, updated_at)
      VALUES ($1, $2, $3, $4, NOW(), NOW()) RETURNING id, created_at, updated_at;',
      [name, min_players, max_players, description])
    if res.ntuples == 1
      update_attributes(res[0])
    else
      false
    end
  end

  def update
    res = Base.connection.exec_params(
      'UPDATE board_games SET name=$1, min_players=$2, max_players=$3, description=$4, updated_at=NOW()
       WHERE id = $5 RETURNING updated_at;',
      [name, min_players, max_players, description, id])

    # TODO refactor in to a method?
    if res.ntuples == 1
      update_attributes(res[0])
    else
      false
    end
  end

  def destroy
    Base.connection.exec_params(
     'DELETE FROM board_games WHERE id = $1',
     [id])
  end


  class << self
    # Returns an array of BoardGame models
    def findAll
      res = self.connection.exec_params('SELECT * FROM board_games ORDER BY id')
      res.map { |row|
        BoardGame.new(row)
      }
    end

    def findById(id)
      res = self.connection.exec_params('SELECT * FROM board_games WHERE id = $1::integer LIMIT 1', [id])
      if res.ntuples == 1
        BoardGame.new(res[0])
      else
        false
      end
    end

    def search(term)
      res = self.connection.exec_params(
      'SELECT * FROM board_games WHERE name ILIKE $1 OR description ILIKE $1 ORDER BY id',
      ["%#{term}%"]
      )
      res.map { |row|
        BoardGame.new(row)
      }
    end
  end

  def update_attributes(params)
    # HACK could be better
    @id = params["id"] if params.has_key?("id")
    @name = params["name"] if params.has_key?("name")
    @min_players = params["min_players"] if params.has_key?("min_players")
    @max_players = params["max_players"] if params.has_key?("max_players")
    @description = params["description"] if params.has_key?("description")
    @created_at = params["created_at"] if params.has_key?("created_at")
    @updated_at = params["updated_at"] if params.has_key?("updated_at")
  end

  def to_s
    "ID: #{id} Name: #{name}"
  end

  def details
    "ID: #{id}\nName: #{name}\nPlayers Min(#{min_players}) Max(#{max_players})\nDescription:\n#{description}\n\nCreated At: #{created_at} Updated: #{updated_at}"
  end
end
