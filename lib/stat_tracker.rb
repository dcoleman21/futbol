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
    ties = @game_teams.find_all {|game| game.result == "TIE"}.count / 2
    total_games = @game_teams.map {|game| game.game_id}.uniq.count

    result = (ties.to_f / total_games.to_f)
    result.round(2)
  end

  def count_of_games_by_season
    seasons = {}
    @games.group_by do |game|
      seasons[game.season] = games.count{|index| index.season == game.season}
    end
    seasons
  end

  def average_goals_per_game
    goals = 0
    total_games = @game_teams.map {|game| game.game_id}.uniq.count
    @game_teams.sum {|game| goals += game.goals}
    average = (goals.to_f / total_games.to_f)
    average.round(2)
  end

  def average_goals_by_season
    goals = 0
    hash = @games.group_by {|game| game.season}

    hash.each do |season, games_array|
      goals = games_array.sum do |game|
        game.away_goals + game.home_goals
      end
      result = goals / games_array.count.to_f
      hash[season] = result.round(2)
    end
      hash
  end

  # League Statistics
  def count_of_teams
    @teams.count
  end

  def best_offense
    games_by_team_id = @game_teams.group_by do |game|
      game.team_id
    end
    games_by_team_id.each do |key, games_array|
      total_games = games_array.count
      total_goals = games_array.sum do |game|
        game.goals
      end
      average = total_goals / total_games.to_f
      games_by_team_id[key] = average
    end
    best = games_by_team_id.key(games_by_team_id.values.max)
    best_team = @teams.each {|team| return team.team_name if team.team_id == best}
  end

  def worst_offense
    games_by_team_id = @game_teams.group_by do |game|
      game.team_id
    end
    games_by_team_id.each do |key, games_array|
      total_games = games_array.count
      total_goals = games_array.sum do |game|
        game.goals
      end
      average = total_goals / total_games.to_f
      games_by_team_id[key] = average
    end
    worst = games_by_team_id.key(games_by_team_id.values.min)
    worst_team = @teams.each {|team| return team.team_name if team.team_id == worst}
  end

  def highest_scoring_visitor
    away_games = @game_teams.find_all {|game| game.hoa == "away"}
    away_games_by_team = away_games.group_by {|game| game.team_id}
    away_games_by_team.each do |team_id, game_array|
      total_games = game_array.count
      total_goals = game_array.sum do |game|
        game.goals
      end
      avg = total_goals / total_games.to_f
      away_games_by_team[team_id] = avg
    end
    best = away_games_by_team.key(away_games_by_team.values.max)
    best_team = @teams.each {|team| return team.team_name if team.team_id == best}
  end

  def highest_scoring_home_team
    home_games = @game_teams.find_all {|game| game.hoa == "home"}
    home_games_by_team = home_games.group_by {|game| game.team_id}
    home_games_by_team.each do |team_id, game_array|
      total_games = game_array.count
      total_goals = game_array.sum do |game|
        game.goals
      end
      avg = total_goals / total_games.to_f
      home_games_by_team[team_id] = avg
    end
    best = home_games_by_team.key(home_games_by_team.values.max)
    best_team = @teams.each {|team| return team.team_name if team.team_id == best}
  end

  def lowest_scoring_visitor
    away_games = @game_teams.find_all {|game| game.hoa == "away"}
    away_games_by_team = away_games.group_by {|game| game.team_id}
    away_games_by_team.each do |team_id, game_array|
      total_games = game_array.count
      total_goals = game_array.sum do |game|
        game.goals
      end
      avg = total_goals / total_games.to_f
      away_games_by_team[team_id] = avg
    end
    worst = away_games_by_team.key(away_games_by_team.values.min)
    worst_team = @teams.each {|team| return team.team_name if team.team_id == worst}
    # Returns a string
  end

  def lowest_scoring_home_team
    home_games = @game_teams.find_all {|game| game.hoa == "home"}
    home_games_by_team = home_games.group_by {|game| game.team_id}
    home_games_by_team.each do |team_id, game_array|
      total_games = game_array.count
      total_goals = game_array.sum do |game|
        game.goals
      end
      avg = total_goals / total_games.to_f
      home_games_by_team[team_id] = avg
    end
    worst = home_games_by_team.key(home_games_by_team.values.min)
    worst_team = @teams.each {|team| return team.team_name if team.team_id == worst}
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
    found = @teams.find {|team| team.team_id == team_id}
    {'team_id' => found.team_id, 'franchise_id' => found.franchise_id, 'team_name' => found.team_name, 'abbreviation' => found.abbreviation, 'link' => found.link}
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
