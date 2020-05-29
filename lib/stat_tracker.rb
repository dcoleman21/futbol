require 'csv'
require_relative 'games'
require_relative 'teams'
require_relative 'game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def self.from_csv(data)
    @games_collection = CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Games.new(row)}
    @teams_collection = CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Teams.new(row)}
    @game_teams_collection = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeams.new(row)}
    StatTracker.new(@games_collection, @teams_collection, @game_teams_collection)
  end

  def initialize(games_collection, teams_collection, game_teams_collection)
    @games      = games_collection
    @teams      = teams_collection
    @game_teams = game_teams_collection
  end

  # Game Statistics
  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    home_games_won = @game_teams.find_all {|game| game.hoa == "home" && game.result == "WIN"}.count
    total_games = @game_teams.map {|game| game.game_id}.uniq.count

    result = (home_games_won.to_f / total_games.to_f)
    result.round(2)
  end

  def percentage_visitor_wins
    visitor_games_won = @game_teams.find_all {|game| game.hoa == "away" && game.result == "WIN"}.count
    total_games = @game_teams.map {|game| game.game_id}.uniq.count

    result = (visitor_games_won.to_f / total_games.to_f)
    result.round(2)
  end

  def percentage_ties
    # Returns a float
  end

  def count_of_games_by_season
    # Returns a hash
  end

  def average_goals_per_game
    # Returns a float
  end

  def average_goals_by_season
    # Returns a hash
  end

  # League Statistics
  def count_of_teams
    # Returns an integer
  end

  def best_offense
    # Returns a string
  end

  def worst_offense
    # Returns a string
  end

  def highest_scoring_visitor
    # Returns a string
  end

  def highest_scoring_home_team
    # Returns a string
  end

  def lowest_scoring_visitor
    # Returns a string
  end

  def lowest_scoring_home_team
    # Returns a string
  end

  # Season Statistics - All methods take a season id as an argument
  def winningest_coach(season_id)
    # Returns a string
  end

  def worst_coach(season_id)
    # Returns a string
  end

  def most_accurate_team(season_id)
    # Returns a string
  end

  def least_accurate_team(season_id)
    # Returns a string
  end

  def most_tackles(season_id)
    # Returns a string
  end

  def fewest_tackles(season_id)
    # Returns a string
  end

  # Team Statistics - All methods take a team id as an argument
  def team_info(team_id)
    # Returns a hash
  end

  def best_season(team_id)
    # Returns a string
  end

  def worst_season(team_id)
    # Returns a string
  end

  def average_win_percentage(team_id)
    # Returns a float
  end

  def most_goals_scored(team_id)
    # Returns an integer
  end

  def fewest_goals_scored(team_id)
    # Returns an integer
  end

  def favorite_oppenent(team_id)
    # Returns a string
  end

  def rival(team_id)
    # Returns a string
  end
end
