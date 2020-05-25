require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({games:      './data/game.csv',
                                          teams:      './data/teams.csv',
                                          game_teams: './data/game_teams.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_readable_attributes
    assert_equal './data/game.csv', @stat_tracker.games
    assert_equal './data/teams.csv', @stat_tracker.teams
    assert_equal './data/game_teams.csv', @stat_tracker.game_teams
  end
end
