require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require './lib/games_collection'
require 'pry'

class GamesCollectionTest < MiniTest::Test
  def setup
    @games_collection = GamesCollection.new("./fixture/games_fixture.csv")
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_has_games
    assert_equal "6", @games_collection.collection[0].away_team_id
    assert_equal "BBVA Stadium", @games_collection.collection[1].venue
    assert_equal 29, @games_collection.collection.count
    assert_equal Games, @games_collection.collection.first.class
  end
end
