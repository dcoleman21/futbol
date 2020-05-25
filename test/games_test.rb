require 'minitest/autorun'
require "minitest/pride"
require './lib/games'
require './lib/stat_tracker'

class GamesTest < Minitest::Test
  def setup
    @games = Games.new({game_id: 2012030221,
                       season: 20122013,
                       type: 'Postseason',
                       date_time: '5/16/13',
                       away_team_id: 3,
                       home_team_id: 6,
                       away_goals: 2,
                       home_goals: 3,
                       venue: 'Toyota Stadium',
                       venue_link: '/api/v1/venues/null'
                       })
  end

  def test_it_exists
    assert_instance_of Games, @games
  end
end
