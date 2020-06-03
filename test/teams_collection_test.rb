require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams_collection'
require './lib/teams'


class TeamsCollectionTest < MiniTest::Test

  def setup
    @teams = TeamsCollection.new("./data/teams.csv")
  end

  def test_exists
    assert_instance_of TeamsCollection, @teams
  end

  def test_it_has_teams
    assert_equal "1", @teams.collection[0].team_id
    assert_equal "16", @teams.collection[1].franchise_id
    assert_equal 32, @teams.collection.count
    assert_equal Teams, @teams.collection.first.class
  end
end
