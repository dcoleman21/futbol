require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require './lib/games_collection'
require 'pry'

class GamesCollectionTest < MiniTest::Test
  def setup
    @game_1 = Games.new({game_id: 2012030221,
                         season: 20122013,
                         type: 'Postseason',
                         date_time: '5/16/13',
                         away_team_id: 3,
                         home_team_id: 6,
                         away_goals: 2,
                         home_goals: 3,
                         venue: 'Toyota Stadium',
                         venue_link: '/api/v1/venues/null'})
    @game_2 = Games.new({game_id: 2012030222,
                         season: 20122013,
                         type: 'Postseason',
                         date_time: '5/19/13',
                         away_team_id: 3,
                         home_team_id: 6,
                         away_goals: 2,
                         home_goals: 3,
                         venue: 'Toyota Stadium',
                         venue_link: '/api/v1/venues/null'})
    @data = [@game_1, @game_2]
  end

  def test_it_exists
    games_collection = GamesCollection.new(@data)

    assert_instance_of GamesCollection, games_collection
  end

  def test_it_has_games
    games_collection = GamesCollection.new(@data)

    assert_equal 3, games_collection.games[0].away_team_id
    assert_equal "Toyota Stadium", games_collection.games[1].venue
  end
end
