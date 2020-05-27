require 'minitest/autorun'
require 'minitest/pride'
require './lib/teams_collection'
require './lib/teams'


class TeamsCollectionTest < MiniTest::Test

  def setup
    @team_1 = Teams.new({team_id: 1,
                       franchise_id: 23,
                       team_name: "Atlanta United",
                       abbreviation: "ATL",
                       stadium: "Mercedes-Benz Stadium",
                       link: "/api/v1/teams/1"
                       })
    @team_2 = Teams.new({team_id: 4,
                       franchise_id: 16,
                       team_name: "Chicago Fire",
                       abbreviation: "CHI",
                       stadium: "SeatGeek Stadium",
                       link: "/api/v1/teams/4"
                       })
    @data = [@team_1, @team_2]
  end

  def test_exists
    teams_collection = TeamsCollection.new(@data)

    assert_instance_of TeamsCollection, teams_collection
  end

  def test_it_has_teams
    teams_collection = TeamsCollection.new(@data)

    assert_equal 1, teams_collection.teams[0].team_id
    assert_equal 16, teams_collection.teams[1].franchise_id
  end
end
