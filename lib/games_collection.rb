require 'CSV'

class GamesCollection 
  attr_reader :games
  def initialize(data)
    @games = data
  end
end
