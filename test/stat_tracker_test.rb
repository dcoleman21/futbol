require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require './lib/teams'
require './lib/game_teams'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({games:      './fixture/games_fixture.csv',
                                          teams:      './data/teams.csv',
                                          game_teams: './fixture/game_teams_fixture.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_generates_collections
    assert_equal 29, @stat_tracker.games.count
    assert_equal 29, @stat_tracker.game_teams.count
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_it_can_access_data
    assert_equal "6", @stat_tracker.games[4].home_team_id
    assert_equal "Chicago Fire", @stat_tracker.teams[1].team_name
    assert_equal "John Tortorella", @stat_tracker.game_teams[5].head_coach
  end
end
