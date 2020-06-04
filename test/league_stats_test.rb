require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/league_stats'

class LeagueStatsTest < MiniTest::Test
  def setup
    data = {games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'}

    @league_stats = LeagueStats.new(data)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_can_count_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_best_offense
    assert_equal "Reign FC", @league_stats.best_offense
  end

  def test_worst_offense
    assert_equal "Utah Royals FC", @league_stats.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @league_stats.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @league_stats.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @league_stats.lowest_scoring_home_team
  end
end
