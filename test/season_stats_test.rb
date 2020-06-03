require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/season_stats'

class SeasonStatsTest < MiniTest::Test
  def setup
    data = {games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'}

    @season_stats = SeasonStats.new(data)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_winningest_coach
    assert_equal "Claude Julien", @season_stats.winningest_coach("20122013")
  end

  def test_it_has_the_worst_coach
    assert_equal "Martin Raymond", @season_stats.worst_coach("20122013")
  end

  def test_it_has_most_accurate_team
    assert_equal "DC United", @season_stats.most_accurate_team("20122013")
  end

  def test_it_has_least_accurate_team
    assert_equal "New York City FC", @season_stats.least_accurate_team("20122013")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @season_stats.most_tackles("20122013")
  end

  def test_it_has_fewest_tackles
    assert_equal "Atlanta United", @season_stats.fewest_tackles("20122013")
  end
end
