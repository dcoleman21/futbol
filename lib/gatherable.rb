module Gatherable
    def calculate_percentage(portion, total)
    (portion / total.to_f).round(2)
  end

  def reassign_hash_values_to_goals_per_game(hash)
    hash.each do |key, games_array|
      goals = games_array.sum {|game| game.goals}
      games = games_array.count
      hash[key] = calculate_percentage(goals, games)
    end
  end

  def gather_season_games(season_id)
    games_in_season = @games.find_all {|game| game.season == season_id}
    season_game_ids = games_in_season.map {|game| game.game_id}
    @game_teams.find_all {|game| season_game_ids.include?(game.game_id)}
  end

  def group_season_wins_by_coach(season_id)
    season_games = gather_season_games(season_id)
    games_grouped_by_coach = season_games.group_by {|game| game.head_coach}
    games_grouped_by_coach.each do |coach, games_array|
      games_grouped_by_coach[coach] = games_array.find_all {|game| game.result == "WIN"}.count
    end
  end
end
