require_relative 'calculable'

class TeamStats < Stats
  include Calculable
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
