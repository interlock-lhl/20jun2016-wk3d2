require 'pg'

class Base
  @@connection = nil
  def self.connection
    @@connection = @@connection || PG.connect({dbname: 'board_games'})
  end

  def self.hmap(hash)
    hash.inject({}) do |hash, (k, v)|
      hash.merge({k.to_sym => v })
    end
    # new_hash = {}
    # hash.each_keys do |key|
    #   new_hash.merge({key.to_sym => hash[key]})
    # end
    # new_hash
  end
end
