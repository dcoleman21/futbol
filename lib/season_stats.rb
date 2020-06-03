class SeasonStats < Stats

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
end
