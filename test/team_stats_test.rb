require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/team_stats'

class TeamStatsTest < MiniTest::Test
  def setup
    data = {games:      './data/games.csv',
            teams:      './data/teams.csv',
            game_teams: './data/game_teams.csv'}

    @team_stats = TeamStats.new(data)
  end

  def test_it_exists
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_displays_team_info
      expected = {'team_id' => '4',
                  'franchise_id' => '16',
                  'team_name' => 'Chicago Fire',
                  'abbreviation' => 'CHI',
                  'link' => '/api/v1/teams/4'}

      assert_equal expected, @team_stats.team_info('4')
  end

  def test_it_has_best_season
    assert_equal "20132014", @team_stats.best_season("6")
  end

  def test_it_has_worst_season
    assert_equal "20142015", @team_stats.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.49, @team_stats.average_win_percentage("6")
    assert_equal 0.43, @team_stats.average_win_percentage("3")
    assert_equal 0.44, @team_stats.average_win_percentage("16")
  end

  def test_most_goals_scored
    assert_equal 6, @team_stats.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("16")
  end

  def test_it_has_favorite_opponent
    assert_equal "Montreal Impact", @team_stats.favorite_opponent("3")
  end

  def test_it_has_a_rival
    assert_equal "Real Salt Lake", @team_stats.rival("6")
  end
end
