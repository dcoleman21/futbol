require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require './lib/game'

class GameTest < MiniTest::Test
  def setup
    @games = Game.new({game_id: 2012030221,
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
    assert_instance_of Game, @games
  end

  def test_it_has_data
    assert_equal 2012030221, @games.game_id
    assert_equal 20122013, @games.season
    assert_equal 'Postseason', @games.type
    assert_equal '5/16/13', @games.date_time
    assert_equal 3, @games.away_team_id
    assert_equal 6, @games.home_team_id
    assert_equal 2, @games.away_goals
    assert_equal 3, @games.home_goals
    assert_equal 'Toyota Stadium', @games.venue
    assert_equal '/api/v1/venues/null', @games.venue_link
  end
end
