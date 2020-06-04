require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'

class StatsTest < MiniTest::Test
  def setup
    @stats = Stats.new({games:      './data/games.csv',
                        teams:      './data/teams.csv',
                        game_teams: './data/game_teams.csv'})
  end

  def test_it_exists
    assert_instance_of Stats, @stats
  end

  def test_it_has_readable_attributes
    assert_equal 7441, @stats.games.count
    assert_equal 14882, @stats.game_teams.count
    assert_equal 32, @stats.teams.count
    assert_equal Game, @stats.games.first.class
    assert_equal Team, @stats.teams.first.class
    assert_equal GameTeam, @stats.game_teams.first.class
  end
end
