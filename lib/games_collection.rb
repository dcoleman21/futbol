require 'CSV'

class GamesCollection < Games
  attr_reader :games
  def initialize(data)
    @games = data
  end
end