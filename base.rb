require 'pg'

class Base
  @@connection = nil
  def self.connection
    @@connection = @@connection || PG.connect({dbname: 'board_games'})
  end
end
