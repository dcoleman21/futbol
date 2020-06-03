require_relative 'calculable'

class GameStats < Stats
  include Calculable

  def unique_games
    @games.count
  end

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    home_games_won = @game_teams.find_all {|game| game.hoa == "home" && game.result == "WIN"}.count
    calculate_percentage(home_games_won, unique_games)
  end

  def percentage_visitor_wins
    away_games_won = @game_teams.find_all {|game| game.hoa == "away" && game.result == "WIN"}.count
    calculate_percentage(away_games_won, unique_games)
  end

  def percentage_ties
    tie_games = @game_teams.find_all {|game| game.result == "TIE"}.count / 2
    calculate_percentage(tie_games, unique_games)
  end

  def count_of_games_by_season
    games_grouped_by_season = @games.group_by {|game| game.season}
    games_grouped_by_season.each {|season, games| games_grouped_by_season[season] = games.count}
  end

  def average_goals_per_game
    total_goals = @game_teams.sum {|game| game.goals}
    calculate_percentage(total_goals, unique_games)
  end

  def average_goals_by_season
    games_grouped_by_season = @games.group_by {|game| game.season}
    games_grouped_by_season.each do |season, games_array|
      goals = games_array.sum {|game| game.away_goals + game.home_goals}
      games_grouped_by_season[season] = calculate_percentage(goals, games_array.count)
    end
  end
end
