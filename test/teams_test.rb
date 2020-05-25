require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams'
require './lib/stat_tracker'

class TeamsTest < MiniTest::Test

  def setup
      @teams = Teams.new({team_id: 1,
                         franchise_id: 23,
                         team_name: "Atlanta United",
                         abbreviation: "ATL",
                         stadium: "Mercedes-Benz Stadium",
                         link: "/api/v1/teams/1"
                         })
  end

  def test_it_exists
    assert_instance_of Teams, @teams
  end

  def test_it_has_data
    assert_equal 1, @teams.team_id
    assert_equal 23, @teams.franchise_id
    assert_equal "Atlanta United", @teams.team_name
    assert_equal "ATL", @teams.abbreviation
    assert_equal "Mercedes-Benz Stadium", @teams.stadium
    assert_equal "/api/v1/teams/1", @teams.link
  end
end
