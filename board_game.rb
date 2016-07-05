require_relative './base'

class BoardGame < Base
  attr_reader :id
  attr_accessor :name, :min_players, :max_players, :description, :created_at, :updated_at

  TABLE_NAME = 'board_games'

  def initialize(params)
    #TODO use Base.hmap to make this symbol keyed
    @id = params['id']
    @name = params['name']
    @min_players = params['min_players']
    @max_players = params['max_players']
    @description = params['description']
    @created_at = params['created_at']
    @updated_at = params['updated_at']
  end

  def is_saved? # is_persisted?
    @id != nil
  end

  def save
    if is_saved? #UPDATE
      res = Base.connection.exec_params("UPDATE #{TABLE_NAME}
      SET name=$1, min_players=$2, max_players=$3, description=$4, updated_at=NOW()
      WHERE id=$5 RETURNING updated_at;", [name, min_players, max_players, description, id])
      #TODO deal with not okay responses
      self.updated_at = res[0]['updated_at'];
    else #INSERT
      res = Base.connection.exec_params("INSERT INTO #{TABLE_NAME}
        (name, min_players, max_players, description, created_at, updated_at) VALUES
        ($1, $2, $3, $4, NOW(), NOW()) RETURNING id, created_at, updated_at;", [name, min_players, max_players, description])
      #TODO make sure this was success
      @id = res[0]['id']
      self.created_at = res[0]['created_at']
      self.updated_at = res[0]['updated_at']
    end
  end

  def delete
    Base.connection.exec_params("DELETE FROM #{TABLE_NAME} WHERE id=$1", [id])
  end

  class << self
    def findAll
      res = self.connection.exec_params("SELECT * FROM #{TABLE_NAME};")
      res.map do |row|
        BoardGame.new(row)
      end
    end

    def find(id)
      res = self.connection.exec_params("SELECT * FROM board_games WHERE id = $1;", [id])
      return nil if res.num_tuples == 0
      BoardGame.new(res[0])
    end
  end
end
