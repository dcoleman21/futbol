class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(data)
    @games      = data[:games]
    @teams      = data[:teams]
    @game_teams = data[:game_teams]

    StatTracker.new(@games, @teams, @game_teams)
  end

  def initialize(games, teams, game_teams)
    @games      = games
    @teams      = teams
    @game_teams = game_teams
  end
end
