require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require './lib/game_teams_collection'
require 'pry'

class GameTeamsCollectionTest < Minitest::Test
  def setup
    @game_teams_1 = GameTeams.new({
      game_id: 2012030221,
      team_id: 3,
      hoa: "away",
      result: "LOSS",
      settled_in: "OT",
      head_coach: "John Tortorella",
      goals: 2,
      shots: 8,
      tackles: 44,
      pim: 8,
      power_play_opportunities: 3,
      power_play_goals: 0,
      face_off_win_percentage: 44.8,
      giveaways: 17,
      takeaways: 7
      })

      @game_teams_2 = GameTeams.new({
        game_id: 2012030221,
        team_id: 6,
        hoa: "home",
        result: "WIN",
        settled_in: "OT",
        head_coach: "Claude Julien",
        goals: 3,
        shots: 12,
        tackles: 51,
        pim: 6,
        power_play_opportunities: 4,
        power_play_goals: 1,
        face_off_win_percentage: 55.2,
        giveaways: 4,
        takeaways: 5
        })

        @data = [@game_teams_1, @game_teams_2]
  end

  def test_it_exists
    game_teams_collection = GameTeamsCollection.new(@data)

    assert_instance_of GameTeamsCollection, game_teams_collection
  end

  def test_it_has_game_teams
    game_teams_collection = GameTeamsCollection.new(@data)

    assert_equal 2012030221, game_teams_collection.game_teams[0].game_id
    assert_equal "WIN", game_teams_collection.game_teams[1].result
  end
end
