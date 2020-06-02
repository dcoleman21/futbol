require 'csv'
require_relative 'games'
require_relative 'teams'
require_relative 'game_teams'
require_relative 'gatherable'

class StatTracker
  include Gatherable
  attr_reader :games, :teams, :game_teams, :unique_games

  def self.from_csv(data)
    @games_collection      = CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Games.new(row)}
    @teams_collection      = CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Teams.new(row)}
    @game_teams_collection = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeams.new(row)}

    StatTracker.new(@games_collection, @teams_collection, @game_teams_collection)
  end

  def initialize(games_collection, teams_collection, game_teams_collection)
    @games        = games_collection
    @teams        = teams_collection
    @game_teams   = game_teams_collection
    @unique_games = @games.count
  end

  # GAME STATISTICS
  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    home_games_won = @game_teams.find_all {|game| game.hoa == "home" && game.result == "WIN"}.count
    calculate_percentage(home_games_won, @unique_games)
  end

  def percentage_visitor_wins
    away_games_won = @game_teams.find_all {|game| game.hoa == "away" && game.result == "WIN"}.count
    calculate_percentage(away_games_won, @unique_games)
  end

  def percentage_ties
    tie_games = @game_teams.find_all {|game| game.result == "TIE"}.count / 2
    calculate_percentage(tie_games, @unique_games)
  end

  def count_of_games_by_season
    games_grouped_by_season = @games.group_by {|game| game.season}
    games_grouped_by_season.each {|season, games| games_grouped_by_season[season] = games.count}
  end

  def average_goals_per_game
    total_goals = @game_teams.sum {|game| game.goals}
    calculate_percentage(total_goals, @unique_games)
  end

  def average_goals_by_season
    games_grouped_by_season = @games.group_by {|game| game.season}
    games_grouped_by_season.each do |season, games_array|
      goals = games_array.sum {|game| game.away_goals + game.home_goals}
      games_grouped_by_season[season] = calculate_percentage(goals, games_array.count)
    end
  end

  # LEAGUE STATISTICS
  def count_of_teams
    @teams.count
  end

  def best_offense
    games_grouped_by_team_id = @game_teams.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(games_grouped_by_team_id)
    best_team = games_grouped_by_team_id.key(games_grouped_by_team_id.values.max)
    @teams.each {|team| return team.team_name if team.team_id == best_team}
  end

  def worst_offense
    games_grouped_by_team_id = @game_teams.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(games_grouped_by_team_id)
    worst_team = games_grouped_by_team_id.key(games_grouped_by_team_id.values.min)
    @teams.each {|team| return team.team_name if team.team_id == worst_team}
  end

  def highest_scoring_visitor
    away_games = @game_teams.find_all {|game| game.hoa == "away"}
    away_games_grouped_by_team = away_games.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(away_games_grouped_by_team)
    best_away_team = away_games_grouped_by_team.key(away_games_grouped_by_team.values.max)
    @teams.each {|team| return team.team_name if team.team_id == best_away_team}
  end

  def highest_scoring_home_team
    home_games = @game_teams.find_all {|game| game.hoa == "home"}
    home_games_grouped_by_team = home_games.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(home_games_grouped_by_team)
    best_home_team = home_games_grouped_by_team.key(home_games_grouped_by_team.values.max)
    @teams.each {|team| return team.team_name if team.team_id == best_home_team}
  end

  def lowest_scoring_visitor
    away_games = @game_teams.find_all {|game| game.hoa == "away"}
    away_games_grouped_by_team = away_games.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(away_games_grouped_by_team)
    worst_visitor = away_games_grouped_by_team.key(away_games_grouped_by_team.values.min)
    @teams.each {|team| return team.team_name if team.team_id == worst_visitor}
  end

  def lowest_scoring_home_team
    home_games = @game_teams.find_all {|game| game.hoa == "home"}
    home_games_grouped_by_team = home_games.group_by {|game| game.team_id}
    reassign_hash_values_to_goals_per_game(home_games_grouped_by_team)
    worst_home_team = home_games_grouped_by_team.key(home_games_grouped_by_team.values.min)
    @teams.each {|team| return team.team_name if team.team_id == worst_home_team}
  end

  # SEASON STATISTICS
  def winningest_coach(season_id)
    season_wins_grouped_by_coach = group_season_wins_by_coach(season_id)
    season_wins_grouped_by_coach.max_by {|_, wins| wins}.first
  end

  def worst_coach(season_id)
    season_wins_grouped_by_coach = group_season_wins_by_coach(season_id)
    season_wins_grouped_by_coach.min_by {|_, wins| wins}.first
  end

  def most_accurate_team(season_id)
    season_games = gather_season_games(season_id)
    season_games_grouped_by_team_id = season_games.group_by {|team| team.team_id}
    goals_to_shots_ratio = season_games_grouped_by_team_id.transform_values do |games_array|
      games_array.sum {|game| game.goals.to_f} / games_array.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == goals_to_shots_ratio.max_by {|_, ratio| ratio}.first}.team_name
  end

  def least_accurate_team(season_id)
    season_games = gather_season_games(season_id)
    season_games_grouped_by_team_id = season_games.group_by {|team| team.team_id}
    goals_to_shots_ratio = season_games_grouped_by_team_id.transform_values do |games_array|
      games_array.sum {|game| game.goals.to_f} / games_array.sum {|game| game.shots}
    end
    @teams.find {|team| team.team_id == goals_to_shots_ratio.min_by {|_, ratio| ratio}.first}.team_name
  end

  def most_tackles(season_id)
    season_games = gather_season_games(season_id)
    season_games_grouped_by_team_id = season_games.group_by {|team| team.team_id}
    tackles_grouped_by_team = season_games_grouped_by_team_id.transform_values do |games_array|
      games_array.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == tackles_grouped_by_team.max_by {|_, ratio| ratio}.first}.team_name
  end

  def fewest_tackles(season_id)
    season_games = gather_season_games(season_id)
    season_games_grouped_by_team_id = season_games.group_by {|team| team.team_id}
    tackles_grouped_by_team = season_games_grouped_by_team_id.transform_values do |games_array|
      games_array.sum {|game| game.tackles}
    end
    @teams.find {|team| team.team_id == tackles_grouped_by_team.min_by {|_, ratio| ratio}.first}.team_name
  end

  # TEAM STATISTICS
  def team_info(team_id)
    found = @teams.find {|team| team.team_id == team_id}
    {'team_id' => found.team_id, 'franchise_id' => found.franchise_id, 'team_name' => found.team_name, 'abbreviation' => found.abbreviation, 'link' => found.link}
  end

  def best_season(team_id)
    team_wins = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}
    winning_game_ids = team_wins.map {|game| game.game_id}
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    team_games_grouped_by_season = team_games.group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids.include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.max_by {|_, win_percentage| win_percentage}.first
  end

  def worst_season(team_id)
    team_wins = @game_teams.find_all {|game| game.team_id == team_id && game.result == "WIN"}
    winning_game_ids = team_wins.map {|game| game.game_id}
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    team_games_grouped_by_season = team_games.group_by {|game| game.season}
    team_games_grouped_by_season.each do |season, games_array|
      wins = games_array.find_all {|game| winning_game_ids.include?(game.game_id)}.count
      team_games_grouped_by_season[season] = wins.to_f / games_array.count
    end
    team_games_grouped_by_season.min_by {|_, win_percentage| win_percentage}.first
  end

  def average_win_percentage(team_id)
    games_played_by_team = @game_teams.find_all {|game| game.team_id == team_id}
    wins = games_played_by_team.find_all {|game| game.result == "WIN"}.count
    calculate_percentage(wins, games_played_by_team.count)
  end

  def most_goals_scored(team_id)
    games_played_by_team = @game_teams.find_all {|game| game.team_id == team_id}
    games_played_by_team.max_by {|game| game.goals}.goals
  end

  def fewest_goals_scored(team_id)
    games_played_by_team = @game_teams.find_all {|game| game.team_id == team_id}
    games_played_by_team.min_by {|game| game.goals}.goals
  end

  def favorite_opponent(team_id)
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    game_ids = team_games.map {|game| game.game_id}
    opposing_team_games = @game_teams.find_all {|game| game_ids.include?(game.game_id) && game.team_id != team_id}
    opposing_teams = opposing_team_games.group_by {|game| game.team_id}
    hash = opposing_teams.transform_values do |games_array|
      wins = games_array.find_all {|game| game.result == "WIN"}.count
      wins.to_f / games_array.count
    end
    opp_team_id = hash.min_by {|_, ratio| ratio}.first
    @teams.find {|team| team.team_id == opp_team_id}.team_name
  end

  def rival(team_id)
    team_games = @games.find_all {|game| game.away_team_id == team_id || game.home_team_id == team_id}
    game_ids = team_games.map {|game| game.game_id}
    opposing_team_games = @game_teams.find_all {|game| game_ids.include?(game.game_id) && game.team_id != team_id}
    opposing_teams = opposing_team_games.group_by {|game| game.team_id}
    hash = opposing_teams.transform_values do |games_array|
      wins = games_array.find_all {|game| game.result == "WIN"}.count
      wins.to_f / games_array.count
    end
    opp_team_id = hash.max_by {|_, ratio| ratio}.first
    @teams.find {|team| team.team_id == opp_team_id}.team_name
  end
end
