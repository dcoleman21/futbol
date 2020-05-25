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
end
