require_relative 'calculable'

class LeagueStats < Stats
  include Calculable

  def reassign_hash_values_to_goals_per_game(hash)
    hash.each do |key, games_array|
      goals = games_array.sum {|game| game.goals}
      games = games_array.count
      hash[key] = calculate_percentage(goals, games)
    end
  end

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
end
