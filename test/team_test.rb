require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'

class TeamTest < MiniTest::Test
  def setup
      @teams = Team.new({team_id: 1,
                         franchiseid: 23,
                         teamname: "Atlanta United",
                         abbreviation: "ATL",
                         stadium: "Mercedes-Benz Stadium",
                         link: "/api/v1/teams/1"
                         })
  end

  def test_it_exists
    assert_instance_of Team, @teams
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
