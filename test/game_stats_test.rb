require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/game_stats'

class GameStatsTest < MiniTest::Test
  def setup
    data = {games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'}

    @game_stats = GameStats.new(data)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_can_get_highest_total_score
    assert_equal 11, @game_stats.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 0, @game_stats.lowest_total_score
  end

  def test_it_has_percentage_of_home_wins
    assert_equal 0.44, @game_stats.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @game_stats.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.2, @game_stats.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }

    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @game_stats.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

    assert_equal expected, @game_stats.average_goals_by_season
  end
end
