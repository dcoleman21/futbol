require 'csv'

class GameTeamsCollection
  attr_reader :game_teams
  
  def initialize(data)
    @game_teams = data
  end


end
