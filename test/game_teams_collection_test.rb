require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require './lib/game_teams_collection'
require 'pry'

class GameTeamsCollectionTest < Minitest::Test
  def setup
    @game_teams = GameTeamsCollection.new("./fixture/game_teams_fixture.csv")
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @game_teams
  end

  def test_it_has_game_teams
    assert_equal "2012030221", @game_teams.collection[0].game_id
    assert_equal "WIN", @game_teams.collection[1].result
    assert_equal 29, @game_teams.collection.count
    assert_equal GameTeams, @game_teams.collection.first.class
  end
end
